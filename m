Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Bluetooth connection hangs after some retries (reset
 required/possible?)
To: linux-bluetooth@vger.kernel.org
References: <56D9A545.7070200@m-reimer.de>
From: Manuel Reimer <mail+linux-bluetooth@m-reimer.de>
Message-ID: <56DAB409.60401@m-reimer.de>
Date: Sat, 5 Mar 2016 11:25:13 +0100
MIME-Version: 1.0
In-Reply-To: <56D9A545.7070200@m-reimer.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/04/2016 04:09 PM, Manuel Reimer wrote:
> Hello,
>
> I'm still doing my first steps with bluetooth on Linux...
>
> I'm trying to get HID reports of a bluetooth game controller (PS4
> gamepad). The relevant lines:
>
> char dest[18] = "XX:XX:XX:XX:XX:XX";
> int int_socket = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
> struct sockaddr_l2 addr = { 0 };
> addr.l2_family = AF_BLUETOOTH;
> str2ba( dest, &addr.l2_bdaddr );
> addr.l2_psm = htobs(L2CAP_PSM_HIDP_INTR);
> connect(int_socket, (struct sockaddr *)&addr, sizeof(addr));
> char buf[79] = { 0 };
> int bytes_read;
> bytes_read = recv(int_socket, buf, sizeof(buf), 0);
> while(1) {
>    if( bytes_read > 0 ) {
>      printf("received [%s]\n", buf);
>    }
> }
>
> Yes, I do proper initialization and yes, my "real code" has error handling.
>
> If I run this code for the first time (currently I have the "hidp"
> module blacklisted to get sure I'm really the first user of the device),
> then everything works as expected. Initialization is done and lines are
> running through console.
>
> Sometimes I'm able to Ctrl+C and restart *once* but it never is possible
> to do a third try. If I do so, then the "read" just hangs forever. This
> also happens if I disconnect the bluetooth device and reconnect it. I
> have to "systemctl restart bluetooth" in this case to get a new chance.
>
> What is happening here? For me it seems like the bluetooth daemon
> "somehow" does some kind of "deadlocking". Maybe the controller keeps
> sending and noone takes the messages which causes the daemon to deadlock?
>
> How to get around this? Is it actually possible to get this stable? Is
> there, for example, some command, I can send, so whatever hangs here is
> reset?
>
> Thank you for every answer...
>
> Best regards,
>
> Manuel
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




I did a few more tries.

This is a "hcidump -x" of one connection from usermode. It sends out one 
report (setting the LEDs on the controller) and successfully receives 10 
HID reports. For whatever reason I don't see all 10 in the hcidump output...

http://pastebin.com/50g2nMWF

And this one is a dump of the "deadlocked" case:

http://pastebin.com/QKWp8E2G

In general both logs look much more "dirty" as a dump created with the 
kernel module (hidp) attached...

Any help would be very welcome. Maybe someone can at least point me to a 
different mailing list where someone may know how to do "stable usermode 
bluetooth programming"?

Thank you very much in advance.

Best regards,

Manuel
