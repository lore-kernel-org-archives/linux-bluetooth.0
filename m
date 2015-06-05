Return-Path: <cyrus@holtmann.org>
Message-ID: <55715F47.7070900@mentor.com>
Date: Fri, 5 Jun 2015 09:35:19 +0100
From: Dean Jenkins <Dean_Jenkins@mentor.com>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "Frkuska,
 Joshua" <Joshua_Frkuska@mentor.com>
Subject: Re: [RFC] Bluetooth ERTM L2CAP deadlocks (hung tasks) due to l2cap_sock_shutdown()
References: <554B8439.9020409@mentor.com> <55683B1E.7090001@mentor.com>
In-Reply-To: <55683B1E.7090001@mentor.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Gustavo and Johan,

We are working on a fix for the Bluetooth ERTM L2CAP deadlock (hung 
task) issue. In particular to fix kernel 3.8, however, I have 
forward-ported the patches to bluetooth-next and I believe the fix is 
appropriate for bluetooth-next as sjanc on IRC was able to reproduce the 
deadlock on bluetooth-next.

I have uploaded our set of proposed patches in 
l2cap_ertm_shutdown_deadlock_patches.tgz to 
https://bugzilla.kernel.org/show_bug.cgi?id=99301

We are still testing so the patches may not be the final versions but 
the signs are good that the solution works.

Feel free to comment and collaborate.

I use the nick "djenkins" in the Bluetooth IRC chat room, please connect 
me if you wish to discuss the issue.

Thanks for your time.

Regards,
Dean

On 29/05/15 11:10, Dean Jenkins wrote:
> Hi Marcel, Gustavo and Johan,
>
> My original E-mail is below for completeness so that you understand 
> the context of this new E-mail.
>
> We have been successful in demonstrating a L2CAP ERTM shutdown 
> deadlock by using the Bluez l2test utility. We think the latest 4.x 
> kernel can also deadlock (not tested).
>
> Details of the simple test case are as follows:
>
> Apparatus
> ======
>
> Raspberry Pi (RPi) original B variant (single ARM core) running Linux 
> Raspian with kernel 3.18.11+ and a USB BT v4.0 dongle. bluez is v5.15 
> (locally built)
> Dell laptop running Linux Mageia 4 with kernel 3.14.32 and an on-board 
> USB BT dongle. bluez is v5.11
>
> Method
> =====
>
> INITIAL SETTINGS:
>
> Ensure bluetoothd is running on the laptop and RPi so the D-Bus 
> services are available for the Bluez utilities to use
> Run bluetoothctl on the laptop and RPi and ensure that an adaptor is 
> shown
>
> Type in the following commands on both systems:
> agent on
> default-agent
> power on
> discoverable on
> scan on
>
> Both systems should now detect each other
>
> Make a note of each device's BT address. Call them <lap_BT_ADDR> and 
> <RPi_BT_ADDR>
>
> On the RPi pair with the laptop (visa versa will also work):
>
> On the RPi do command
> pair <lap_BT_ADDR>
> Accept the pin code
>
> On the laptop do
> Accept the pin code
>
> Pairing should now be successful. bluetoothd must continue to run so 
> that the linkkeys can be serviced by the agent.
>
> bluetoothctl can be quit on both systems
>
> USING L2TEST
>
> l2test can be used in various modes of operation controlled via 
> command line options. l2test can be used in a client-server 
> arrangement whereby 1 BT device listens for a connection (server) and 
> the other BT device connects (client) to the listening device.
>
> For this testcase:
>
> RPi is the l2test client (unit under test)
> laptop is the l2test server
>
> On the laptop use the command:
> l2test -i hci0 -X ertm -d
> This command listens for connections with optional L2CAP ERTM 
> supported and dumps out the received data.
>
> TEST 1: NON-ERTM CONNECTION
>
> On the RPi use the command:
> l2test -s -b 1024 -B /dev/urandom -P 4113 <lap_BT_ADDR>
> This command sends 1024 bytes to the laptop via PSM 4113 used by 
> l2test over a L2CAP basic mode channel.
>
> TEST 2: ERTM CONNECTION
>
> On the RPi use the command:
> l2test -s -b 1024 -B /dev/urandom -X ertm -P 4113 <lap_BT_ADDR>
> This command sends 1024 bytes to the laptop via PSM 4113 used by 
> l2test over an ERTM channel
>
> Results
> =====
>
> TEST 1
>
> root@raspberrypi:~# l2test -s -b 1024 -B /dev/urandom -P 4113 
> 5C:F3:70:68:BA:DD
> l2test[10346]: Connected to 5C:F3:70:68:BA:DD (bredr, psm 4113, scid 64)
> l2test[10346]: Local device 5C:F3:70:68:BA:DA (bredr, psm 4113, scid 64)
> l2test[10346]: Options [imtu 672, omtu 672, flush_to 65535, mode 0, 
> handle 11, class 0x000000, priority 0, rcvbuf 163840]
> l2test[10346]: Sending ...
> l2test[10346]: Closing channel ...
> l2test[10346]: Done
> l2test[10346]: Exit
>
> Using basic L2CAP mode, the channel sends and closes OK.
> l2test terminates as expected.
>
> TEST 2
>
> root@raspberrypi:~# l2test -s -b 1024 -B /dev/urandom -X ertm -P 4113 
> 5C:F3:70:68:BA:DD
> l2test[10366]: Connected to 5C:F3:70:68:BA:DD (bredr, psm 4113, scid 64)
> l2test[10366]: Local device 5C:F3:70:68:BA:DA (bredr, psm 4113, scid 64)
> l2test[10366]: Options [imtu 672, omtu 672, flush_to 65535, mode 3, 
> handle 11, class 0x000000, priority 0, rcvbuf 163840]
> l2test[10366]: Sending ...
> l2test[10366]: Closing channel ...
>
> Using L2CAP ERTM, the channel is instructed to close but hangs.
> l2test fails to naturally terminate.
>
> From Bluez 5.15 tools/l2test.c:
> static void send_mode(int sk)
> {
>     do_send(sk);
>
>     syslog(LOG_INFO, "Closing channel ...");
>     if (shutdown(sk, SHUT_RDWR) < 0)
>         syslog(LOG_INFO, "Close failed: %m");
>     else
>         syslog(LOG_INFO, "Done");
> }
>
> The -s send l2test command line option calls send_mode() to send the 
> data via do_send() and then closes the channel with the call to 
> shutdown().
> do_send() is probably not checking that the data was successfully sent 
> before returning meaning potentially not all the I frames were ACK'ed.
>
> The results shows that shutdown() fails to return as no "Done" textual 
> message is seen.
>
> When the RPi is left in this condition for up to 10 minutes (need to 
> wait longer than 2 times the hung task detector period plus L2CAP 
> timer expiry time), dmesg shows:
>
> [  601.116119] INFO: task kworker/0:1:19 blocked for more than 120 
> seconds.
> [  601.116156]       Not tainted 3.18.11+ #781
> [  601.116169] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [  601.116183] kworker/0:1     D c054cbcc     0    19      2 0x00000000
> [  601.116537] Workqueue: events l2cap_retrans_timeout [bluetooth]
> [  601.116685] [<c054cbcc>] (__schedule) from [<c054cfa4>] 
> (schedule+0x40/0x8c)
> [  601.116727] [<c054cfa4>] (schedule) from [<c054d3c8>] 
> (schedule_preempt_disabled+0x30/0x40)
> [  601.116812] [<c054d3c8>] (schedule_preempt_disabled) from 
> [<c054ee14>] (__mutex_lock_slowpath+0xb8/0x18c)
> [  601.116856] [<c054ee14>] (__mutex_lock_slowpath) from [<c054ef20>] 
> (mutex_lock+0x38/0x3c)
> [  601.117085] [<c054ef20>] (mutex_lock) from [<bf05173c>] 
> (l2cap_retrans_timeout+0x24/0x5c [bluetooth])
> [  601.117371] [<bf05173c>] (l2cap_retrans_timeout [bluetooth]) from 
> [<c003aa68>] (process_one_work+0x13c/0x444)
> [  601.117410] [<c003aa68>] (process_one_work) from [<c003b954>] 
> (worker_thread+0x190/0x580)
> [  601.117445] [<c003b954>] (worker_thread) from [<c003fdb4>] 
> (kthread+0xd8/0xf4)
> [  601.117488] [<c003fdb4>] (kthread) from [<c000e8c8>] 
> (ret_from_fork+0x14/0x20)
> [  601.117569] INFO: task kworker/u3:2:327 blocked for more than 120 
> seconds.
> [  601.117588]       Not tainted 3.18.11+ #781
> [  601.117601] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [  601.117614] kworker/u3:2    D c054cbcc     0   327      2 0x00000000
> [  601.117806] Workqueue: hci0 hci_rx_work [bluetooth]
> [  601.117941] [<c054cbcc>] (__schedule) from [<c054cfa4>] 
> (schedule+0x40/0x8c)
> [  601.117981] [<c054cfa4>] (schedule) from [<c054d3c8>] 
> (schedule_preempt_disabled+0x30/0x40)
> [  601.118056] [<c054d3c8>] (schedule_preempt_disabled) from 
> [<c054ee14>] (__mutex_lock_slowpath+0xb8/0x18c)
> [  601.118092] [<c054ee14>] (__mutex_lock_slowpath) from [<c054ef20>] 
> (mutex_lock+0x38/0x3c)
> [  601.118307] [<c054ef20>] (mutex_lock) from [<bf04d2c8>] 
> (l2cap_get_chan_by_scid+0x28/0x98 [bluetooth])
> [  601.118696] [<bf04d2c8>] (l2cap_get_chan_by_scid [bluetooth]) from 
> [<bf054590>] (l2cap_recv_frame+0xa4/0x2cec [bluetooth])
> [  601.119146] [<bf054590>] (l2cap_recv_frame [bluetooth]) from 
> [<bf058194>] (l2cap_recv_acldata+0x214/0x22c [bluetooth])
> [  601.119559] [<bf058194>] (l2cap_recv_acldata [bluetooth]) from 
> [<bf02bf88>] (hci_rx_work+0x180/0x288 [bluetooth])
> [  601.119801] [<bf02bf88>] (hci_rx_work [bluetooth]) from 
> [<c003aa68>] (process_one_work+0x13c/0x444)
> [  601.119839] [<c003aa68>] (process_one_work) from [<c003b954>] 
> (worker_thread+0x190/0x580)
> [  601.119883] [<c003b954>] (worker_thread) from [<c003fdb4>] 
> (kthread+0xd8/0xf4)
> [  601.119919] [<c003fdb4>] (kthread) from [<c000e8c8>] 
> (ret_from_fork+0x14/0x20)
>
> Conclusions
> ========
>
> The hung task failure is easy to reproduce with the l2test utility. It 
> could be argued that the do_send() function should only return when 
> all the data has been successfully acknowledged but on the other hand, 
> it is ideal to generate the right conditions for the failure to be 
> triggered.
>
> Probably, the low resources on the RPi help to make the failure more 
> likely than using a PC for example.
>
> hcidump shows that the S RR frame from the laptop comes 320ms after 
> the last I frame from the RPi which generates a window of opportunity 
> for the shutdown() call to execute l2cap_sock_shutdown() before the S 
> RR frame has been processed.
>
> It can be seen that the root cause function __l2cap_wait_ack() is not 
> reported by the hung task detector because the function is running in 
> an infinite loop but periodically waiting (sleeping) for 200ms so is 
> not detectable by the hung task detector. The hung task detector is 
> triggered when the L2CAP recovery timers expire 
> (l2cap_retrans_timeout) and gets blocked, or when a new frame is 
> received (l2cap_get_chan_by_scid) and processing gets blocked.
>
> We looked at a range of kernels from 3.8 to 4.0 which we think can 
> suffer the deadlock.
>
> We managed to get a deadlock on Fedora using kernel 4.0.4 but it was a 
> different test case with an iPhone.
>
> Please can we work together to find a solution to the deadlock ?
>
> Note that our interest is in fixing kernels 3.8 and 3.14 so hopefully 
> any fix to the latest 4.x kernel can be back-ported to the kernels 
> that we are using.
>
> Many thanks for your time.
>
> Regards,
> Dean
>
> On 07/05/15 16:26, Dean Jenkins wrote:
>> Hi Marcel, Gustavo and Johan,
>>
>> Please see the end of the E-mail for a workaround, do you agree with 
>> the workaround, any comments ?
>>
>> Description of L2CAP ERTM deadlock
>> ======================
>>
>> Using kernel 3.8 on an ARM i.MX6 based platform, we have identified 
>> some deadlock situations involving L2CAP ERTM. We believe kernel 
>> v4.0.1 can deadlock as well (not tested it) as the affected code is 
>> similar to kernel 3.8.
>>
>> With a L2CAP ERTM channel connected, and l2cap_sock_shutdown() is 
>> called, then __l2cap_wait_ack() is called which is supposed to wait 
>> for all sent I frames to be acknowledged.
>>
>> l2cap_sock_shutdown() takes all 3 locks namely:
>>
>> mutex_lock(&conn->chan_lock);
>> l2cap_chan_lock(chan);
>> lock_sock(sk);
>>
>> __l2cap_wait_ack() is implemented as follows:
>>
>> int __l2cap_wait_ack(struct sock *sk)
>> {
>>     struct l2cap_chan *chan = l2cap_pi(sk)->chan;
>>     DECLARE_WAITQUEUE(wait, current);
>>     int err = 0;
>>     int timeo = HZ/5;
>>
>>     add_wait_queue(sk_sleep(sk), &wait);
>>     set_current_state(TASK_INTERRUPTIBLE);
>>     while (chan->unacked_frames > 0 && chan->conn) {
>>         if (!timeo)
>>             timeo = HZ/5;
>>
>>         if (signal_pending(current)) {
>>             err = sock_intr_errno(timeo);
>>             break;
>>         }
>>
>>         release_sock(sk);
>>         timeo = schedule_timeout(timeo);
>>         lock_sock(sk);
>>         set_current_state(TASK_INTERRUPTIBLE);
>>
>>         err = sock_error(sk);
>>         if (err)
>>             break;
>>     }
>>     set_current_state(TASK_RUNNING);
>>     remove_wait_queue(sk_sleep(sk), &wait);
>>     return err;
>> }
>>
>> Analysis shows that the while loop checks chan->unacked_frames > 0 
>> and chan->conn is !NULL. So when both are true the loop waits 
>> (sleeps) for 200ms using schedule_timeout() and then rechecks the 
>> while loop conditions before waiting again.
>>
>> Unfortunately, during this waiting (sleeping) period the following 
>> locks are still held:
>> mutex_lock(&conn->chan_lock);
>> l2cap_chan_lock(chan);
>>
>> These held locks prevent l2cap_recv_frame() from processing the 
>> received ACKs for the sent I frames in ERTM. This means 
>> chan->unacked_frames > 0 remains true.
>>
>> chan->conn cannot be set to NULL by the channel being closed by other 
>> means as the held locks prevent the state being updated.
>>
>> Therefore a deadlock occurs because __l2cap_wait_ack() gets stuck in 
>> an infinite loop which periodically waits (sleeps). The kernel's hung 
>> task detector is not able to detect this "hung" thread because the 
>> thread periodically runs. This means l2cap_sock_shutdown() does not 
>> return. With debug, we have proven that the infinite loop occurs.
>>
>> Here is an example hung task log and LOCKDEP output of a L2CAP ERTM 
>> deadlock scenario: (we do have some other different traces as well so 
>> more than 1 failure scenario exists)
>>
>> [  360.497912] INFO: task kworker/u:0H:7 blocked for more than 180 
>> seconds.
>> [  360.497931] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
>> disables this message.
>> [  360.497944] kworker/u:0H    D 8046bb28     0     7      2 0x00000000
>> [  360.498051] Backtrace:
>> [  360.498145] [<8046b624>] (__schedule+0x0/0x790) from [<8046be3c>] 
>> (schedule+0x88/0x8c)
>> [  360.498231] [<8046bdb4>] (schedule+0x0/0x8c) from [<8046c1c8>] 
>> (schedule_preempt_disabled+0x18/0x24)
>> [  360.498318] [<8046c1b0>] (schedule_preempt_disabled+0x0/0x24) from 
>> [<80469b70>] (mutex_lock_nested+0x250/0x3e8)
>> [  360.498495] [<80469920>] (mutex_lock_nested+0x0/0x3e8) from 
>> [<7f44d2a8>] (l2cap_get_chan_by_scid+0x24/0x54 [bluetooth])
>> [  360.498696] [<7f44d284>] (l2cap_get_chan_by_scid+0x0/0x54 
>> [bluetooth]) from [<7f453f68>] (l2cap_recv_frame+0x1918/0x1cc8 
>> [bluetooth])
>> [  360.498779]  r6:0000006b r5:9773ef00 r4:96bfdc00 r3:0000003f
>> [  360.498919] [<7f452650>] (l2cap_recv_frame+0x0/0x1cc8 [bluetooth]) 
>> from [<7f454e3c>] (l2cap_recv_acldata+0xc0/0x1f8 [bluetooth])
>> [  360.499088] [<7f454d7c>] (l2cap_recv_acldata+0x0/0x1f8 
>> [bluetooth]) from [<7f437c74>] (hci_rx_work+0x1b4/0x2ec [bluetooth])
>> [  360.499176]  r6:9759a000 r5:9759a77c r4:9773ef00 r3:00000000
>> [  360.499259] [<7f437ac0>] (hci_rx_work+0x0/0x2ec [bluetooth]) from 
>> [<8003ee1c>] (process_one_work+0x344/0x540)
>> [  360.499352] [<8003ead8>] (process_one_work+0x0/0x540) from 
>> [<8003f2e4>] (worker_thread+0x298/0x3ec)
>> [  360.499449] [<8003f04c>] (worker_thread+0x0/0x3ec) from 
>> [<80044a40>] (kthread+0xb4/0xc0)
>> [  360.499543] [<8004498c>] (kthread+0x0/0xc0) from [<8000da30>] 
>> (ret_from_fork+0x14/0x24)
>> [  360.499622]  r7:00000000 r6:00000000 r5:8004498c r4:a40a3e34
>> [  360.499880]
>> Showing all locks held in the system:
>> [  360.499909] 3 locks held by kworker/u:0H/7:
>> [  360.499921]  #0:  (hdev->name){++++..}, at: [<8003ed28>] 
>> process_one_work+0x250/0x540
>> [  360.499968]  #1:  ((&hdev->rx_work)){+.+...}, at: [<8003ed28>] 
>> process_one_work+0x250/0x540
>> [  360.500009]  #2:  (&conn->chan_lock){+.+...}, at: [<7f44d2a8>] 
>> l2cap_get_chan_by_scid+0x24/0x54 [bluetooth]
>> <snip>
>> [  360.500256] 3 locks held by kworker/1:2/64:
>> [  360.500266]  #0:  (events){.+.+..}, at: [<8003ed28>] 
>> process_one_work+0x250/0x540
>> [  360.500307]  #1: ((&(&chan->retrans_timer)->work)){+.+...}, at: 
>> [<8003ed28>] process_one_work+0x250/0x540
>> [  360.500346]  #2:  (&chan->lock){+.+...}, at: [<7f450414>] 
>> l2cap_retrans_timeout+0x24/0x58 [bluetooth]
>> <snip>
>> [  360.502066] 2 locks held by <userland BT daemon>/1433:
>> [  360.502076]  #0:  (&conn->chan_lock){+.+...}, at: [<7f455378>] 
>> l2cap_sock_shutdown+0x34/0x130 [bluetooth]
>> [  360.502179]  #1:  (&chan->lock){+.+...}, at: [<7f455388>] 
>> l2cap_sock_shutdown+0x44/0x130 [bluetooth]
>> <snip>
>>
>> It can be seen that l2cap_get_chan_by_scid() is blocked so that the 
>> ACK cannot be processed and l2cap_retrans_timeout() has timed out in 
>> an attempt to retransmit the I frame but is also blocked. The 
>> Bluetooth stack is now paralysed.
>>
>> This scenario will fail every time. The locking seems to be flawed in 
>> l2cap_sock_shutdown() for L2CAP ERTM. Did it ever work ?
>>
>>
>> Workaround
>> ========
>>
>> Here is our workaround patch (based on kernel 3.8) which releases all 
>> the locks before waiting (sleeping):
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index a53f47a..bf49066 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -1766,7 +1766,13 @@ int __l2cap_wait_ack(struct sock *sk)
>>                 }
>>
>>                 release_sock(sk);
>> +               l2cap_chan_unlock(chan);
>> +               if (chan->conn)
>> + mutex_unlock(&chan->conn->chan_lock);
>>                 timeo = schedule_timeout(timeo);
>> +               if (chan->conn)
>> + mutex_lock(&chan->conn->chan_lock);
>> +               l2cap_chan_lock(chan);
>>                 lock_sock(sk);
>>                 set_current_state(TASK_INTERRUPTIBLE);
>>
>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>> index 657b3a4..bd0d1ae 100644
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -867,8 +867,10 @@ static int l2cap_sock_shutdown(struct socket 
>> *sock, int how)
>>         lock_sock(sk);
>>
>>         if (!sk->sk_shutdown) {
>> -               if (chan->mode == L2CAP_MODE_ERTM)
>> +               if (chan->mode == L2CAP_MODE_ERTM) {
>>                         err = __l2cap_wait_ack(sk);
>> +                       conn = chan->conn;
>> +               }
>>
>>                 sk->sk_shutdown = SHUTDOWN_MASK;
>>
>> If you think this is the right approach then we will formally create 
>> a patch and send it to the mailing list for review.
>>
>> Our initial tests show that the deadlock no longer occurs with the 
>> patch applied, but we are worried about side effects.
>>
>> We have some doubts:
>>
>> a) What are the locks protecting ? Do all 3 locks need to be taken ?
>>
>> b) Can a better architectural solution be created that avoids the 
>> locks ?
>>
>> Perhaps arm the channel to disconnect, then after all ACKs have been 
>> received, call a callback to wake up l2cap_sock_shutdown ?
>>
>> c) What stops new I frames being sent during the waiting period so 
>> chan->unacked_frames increases ?
>>
>> Thanks for your time.
>>
>> Regards,
>> Dean
>>
>


-- 
Dean Jenkins
Embedded Software Engineer
Linux Transportation Solutions
Mentor Embedded Software Division
Mentor Graphics (UK) Ltd.
