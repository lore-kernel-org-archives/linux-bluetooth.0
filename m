Return-Path: <cyrus@holtmann.org>
Content-Type: multipart/mixed; boundary=----------rSbpI5VvDVpBVS9cvvCzQa
To: "Peter Hurley" <peter@hurleysoftware.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: A couple of questions related to a rfcomm server
Reply-To: ssc@tziranda.com
References: <op.vyj0grkdv7v2p6@capela.tziranda.net>
 <1311524784.2657.21.camel@THOR> <op.vy483mhctnyi5l@mediacenter.lan>
 <1311631517.4311.73.camel@THOR>
Date: Mon, 01 Aug 2011 16:09:45 +0100
MIME-Version: 1.0
From: =?iso-8859-15?Q?S=E9rgio_Capela?= <ssc@tziranda.com>
Message-ID: <op.vzji2jb3v7v2p6@capela.tziranda.net>
In-Reply-To: <1311631517.4311.73.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

------------rSbpI5VvDVpBVS9cvvCzQa
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: Quoted-Printable

Hi Peter,

Em Mon, 25 Jul 2011 23:05:17 +0100, Peter Hurley  =

<peter@hurleysoftware.com> escreveu:

> Hi S=E9rgio,
>
> On Sun, 2011-07-24 at 18:08 -0400, S=E9rgio Capela wrote:
>> Hi Peter,
>>
> ....
>> > If you have to have server-side discovery, you could only perform
>> > inquiry with one controller at a time. That way, the other  =

>> controller's
>> > available for new rfcomm connections (assuming your client  =

>> load-balances
>> > like that...).
>> >
>>
>> Yep, that is what I'm doing. I bind one adapter to the rfcomm server =
and
>> use the other one for discovery and content delivery. The main proces=
s
>> thread is the accept server and both the inquiry and the content  =

>> delivery
>> are done in threads launched for the purpose. I also made more tests
>> recently and what is happening is that as soon as the inquiry starts =
the
>> server stops accepting connections and starts processing inquiry resu=
lt
>> events, however, after a couple of minutes I can see the server both
>> accepting and processing new connections and new inquiry result event=
s.
>> The end result is that launching an inquiry leads me to loose possibl=
e
>> connections during a few minutes which is excessive for this case whe=
re
>> inquiries would be launched regularly.
>
> Inquiry in the host stack does serialize wrt. several other ioctl
> functions; however, this is per device. Running a simple test here
> produces expected results, ie. concurrent discovery and connections:
>   1. Start inquiry on device hci1. eg.,
>          hcitool -i hci1 inq --length=3D30
>   2. Initiate connection on device hci0. In my case, turning on a
>      bluetooth headset initiates a connection. Of course, the headset
>      was previously paired.
>
> You may need to confirm where/what your threads are blocked on (well, =
at
> least your main process thread that should be blocked on the accept
> syscall). Stack backtrace in gdb would clear that up.
>

I was able to test this today to make sure that a block was not the caus=
e  =

of the problem. The thread isn't blocked since it remains printing to  =

stdout on the accept thread.

I'm calling the client from a separate machine using the following shell=
  =

command:

while [ 1 ]; do ./rfcomm-client; sleep 5; done

where rfcomm-client is the simple example found in the web from the  =

bluetooth introduction book.

The response from my server is:

waiting for connection
waiting for connection
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala  =

tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"=
}]}]
thread created and detached
waiting for connection
thread end
waiting for connection
waiting for connection
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala  =

tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"=
}]}]
thread created and detached
waiting for connection
thread end
waiting for connection
waiting for connection
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala  =

tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"=
}]}]
thread created and detached
waiting for connection
thread end
waiting for connection
waiting for connection
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala  =

tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"=
}]}]
thread created and detached
thread end
waiting for connection
waiting for connection
waiting for connection

where "waiting for connection" is written to stdout before the accept  =

call. The timeout for the accept is of 1.5 seconds.

In attachment I send two logs with my results when I turn on the rssi  =

inquiry. For testing purposes I initiate the inquiry when receiving a  =

client connection if one isn't already running.

- ssh-output.txt is the log for the client where the error message I get=
  =

is presented in one line followed by the time in seconds in another;

- shell-output.txt is the log for the server where both the accept serve=
r  =

messages and the inquiry messages are present. The content of the file i=
s  =

similar to the one already presented except for the following:
	-- inquiry start logged with two lines: "Inquiry" and "Starting inquiry=
  =

with RSSI..." which appears whenever I start a inquiry;
	-- inquiry results: "<TZ_OK> RSSI 188  Time 1312194878" which shows the=
  =

result of a curl call from within the program followed by a "RSSI" value=
  =

and time in seconds.

 From the server log it can be seen that I initiate a inquiry in respons=
e  =

to a connection and start receiving inquiry responses at time 1312194729=
  =

and at the same time I stop receiving connections despite the "waiting f=
or  =

connection" logged output. Inspecting the client log I see six failed  =

connection attempts from Time 1312194740 to time 1312194791. Going to th=
e  =

sever log again I can see that I then receive 3 connection from the clie=
nt  =

with the inquiry still running as seen below.

<TZ_OK> RSSI 200  Time 1312194794
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala  =

tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"=
}]}]
thread created and detached
waiting for connection
thread end
waiting for connection
waiting for connection
<TZ_OK> RSSI 190  Time 1312194799

<TZ_OK> RSSI 182  Time 1312194801
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala  =

tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"=
}]}]
thread created and detached
waiting for connection
thread end
<TZ_OK> RSSI 181  Time 1312194801

<TZ_OK> RSSI 186  Time 1312194804
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala  =

tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"=
}]}]
thread created and detached
waiting for connection
thread end
waiting for connection
<TZ_OK> RSSI 189  Time 1312194809

I then start another inquiry:

<TZ_OK> RSSI 190  Time 1312194811
<TZ_OK>accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala  =

tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"=
}]}]
thread created and detached
Inquiry
waiting for connection
Starting inquiry with RSSI...
thread end
  RSSI 189  Time 1312194812

And start loosing connections again:

uh oh: Invalid argument
Time 1312194823

>> >> Another question is related to a rfcomm client getting into D stat=
e  =

>> and
>> >> thus not killable.
> ...
>> >
>> > Although I'm not certain that they would fix the problem you're  =

>> having,
>> > I just posted a patch series that resolves some issues with lost  =

>> wakeups
>> > in rfcomm and l2cap. They need testing. You'd need patches 1~4 of 7=
.
>> >
>> > Please feel free to reply direct regarding whether you can test the=
se
>> > and what that outcome was.
>>
>> I suppose those patches would be available in the git sources right? =
At
>> the moment I can't test it but in a week or two I will try to compile=
  =

>> the
>> sources and unless I encounter some problem I will reply in this topi=
c.
>
> Well, right now, those patches are on the mailing list. I was really
> looking to get some more testing on them _prior_ to them making their
> way into the kernel. They're mostly associated with missing wakeups --=

> although it's possible they could fix the D state client, I couldn't
> hypothesize how the rfcomm socket could become uninterruptible from wh=
at
> I fixed. They may be unrelated.
>

I thought the patches were on the user side of things and not on the  =

kernel side. I can't really test this since I can't even afford the disk=
  =

space needed for the kernel compilation because I'm making these tests i=
n  =

a resource limited machine. Also I can't make the machine unstable.

Regards,
S=E9rgio Capela

> Regards,
> Peter
>


-- =

S=E9rgio Pedro dos Santos Capela - Tziranda

Polo Tecnol=F3gico de Lisboa
Edif=EDcio Empresarial 3
1600-546 Lisboa

Telf:  21 314 09 83
Telml: 96 491 94 37
Email: ssc@tziranda.com
------------rSbpI5VvDVpBVS9cvvCzQa
Content-Disposition: attachment; filename=ssh-output.txt
Content-Type: text/plain; name="ssh-output.txt"
Content-Transfer-Encoding: 7bit

ssc@faustmusik:~$ while [ 1 ]; do ./rfcomm-client; sleep 5; done
uh oh: Invalid argument
Time 1312194740
uh oh: Invalid argument
Time 1312194750
uh oh: Invalid argument
Time 1312194760
uh oh: Invalid argument
Time 1312194770
uh oh: Invalid argument
Time 1312194780
uh oh: Invalid argument
Time 1312194791
uh oh: Invalid argument
Time 1312194823
uh oh: Invalid argument
Time 1312194833
uh oh: Invalid argument
Time 1312194844
uh oh: Invalid argument
Time 1312194854
uh oh: Invalid argument
Time 1312194865
uh oh: Invalid argument
Time 1312194920
uh oh: Invalid argument
Time 1312194933
uh oh: Invalid argument
Time 1312194949
uh oh: Invalid argument
Time 1312194964
uh oh: Invalid argument
Time 1312195064

ssc@faustmusik:~$ 
------------rSbpI5VvDVpBVS9cvvCzQa
Content-Disposition: attachment; filename=shell-output.txt
Content-Type: text/plain; name="shell-output.txt"
Content-Transfer-Encoding: 7bit

root@BlackBox01:/home/ssc/bluez_tests# ./rfcomm-server BlackBox1
waiting for connection
waiting for connection
waiting for connection
waiting for connection
waiting for connection
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
Inquiry
waiting for connection
Starting inquiry with RSSI...
thread end
 RSSI 192  Time 1312194729
<TZ_OK> RSSI 189  Time 1312194729
<TZ_OK> RSSI 192  Time 1312194730
<TZ_OK> RSSI 183  Time 1312194730
waiting for connection
<TZ_OK> RSSI 193  Time 1312194731
<TZ_OK> RSSI 186  Time 1312194731
<TZ_OK> RSSI 198  Time 1312194731
<TZ_OK> RSSI 191  Time 1312194731
<TZ_OK> RSSI 189  Time 1312194731
<TZ_OK> RSSI 189  Time 1312194731
<TZ_OK> RSSI 194  Time 1312194731
<TZ_OK> RSSI 181  Time 1312194731
<TZ_OK> RSSI 188  Time 1312194732
waiting for connection
<TZ_OK> RSSI 195  Time 1312194732
<TZ_OK> RSSI 188  Time 1312194732
<TZ_OK> RSSI 182  Time 1312194732
<TZ_OK> RSSI 184  Time 1312194732
<TZ_OK> RSSI 194  Time 1312194732
<TZ_OK> RSSI 198  Time 1312194732
<TZ_OK> RSSI 193  Time 1312194732
<TZ_OK> RSSI 193  Time 1312194733
<TZ_OK> RSSI 192  Time 1312194733
<TZ_OK> RSSI 179  Time 1312194733
<TZ_OK> RSSI 187  Time 1312194733
<TZ_OK> RSSI 194  Time 1312194733
<TZ_OK> RSSI 199  Time 1312194733
<TZ_OK> RSSI 178  Time 1312194733
<TZ_OK> RSSI 183  Time 1312194733
<TZ_OK>waiting for connection
 RSSI 185  Time 1312194733
<TZ_OK> RSSI 194  Time 1312194733
<TZ_OK> RSSI 199  Time 1312194734
<TZ_OK> RSSI 185  Time 1312194734
<TZ_OK> RSSI 203  Time 1312194734
<TZ_OK> RSSI 179  Time 1312194734
<TZ_OK> RSSI 187  Time 1312194734
<TZ_OK> RSSI 196  Time 1312194734
<TZ_OK> RSSI 192  Time 1312194735
<TZ_OK> RSSI 187  Time 1312194735
<TZ_OK>waiting for connection
 RSSI 180  Time 1312194735
<TZ_OK> RSSI 181  Time 1312194735
<TZ_OK> RSSI 189  Time 1312194735
<TZ_OK> RSSI 194  Time 1312194735
<TZ_OK> RSSI 173  Time 1312194736
<TZ_OK> RSSI 180  Time 1312194736
<TZ_OK> RSSI 188  Time 1312194736
<TZ_OK>waiting for connection
 RSSI 194  Time 1312194736
<TZ_OK> RSSI 200  Time 1312194737
<TZ_OK> RSSI 192  Time 1312194737
<TZ_OK> RSSI 199  Time 1312194737
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 175  Time 1312194742
<TZ_OK> RSSI 188  Time 1312194742
<TZ_OK> RSSI 179  Time 1312194743
<TZ_OK> RSSI 197  Time 1312194743
<TZ_OK> RSSI 192  Time 1312194743
<TZ_OK> RSSI 187  Time 1312194743
<TZ_OK> RSSI 184  Time 1312194743
<TZ_OK> RSSI 179  Time 1312194743
<TZ_OK> RSSI 182  Time 1312194743
<TZ_OK> RSSI 188  Time 1312194743
<TZ_OK> RSSI 179  Time 1312194743
<TZ_OK> RSSI 181  Time 1312194743
<TZ_OK> RSSI 203  Time 1312194743
<TZ_OK> RSSI 198  Time 1312194743
<TZ_OK> RSSI 186  Time 1312194743
<TZ_OK> RSSI 180  Time 1312194743
<TZ_OK> RSSI 183  Time 1312194744
<TZ_OK> RSSI 180  Time 1312194744
<TZ_OK> RSSI 201  Time 1312194744
<TZ_OK> RSSI 182  Time 1312194744
<TZ_OK>waiting for connection
 RSSI 196  Time 1312194744
<TZ_OK> RSSI 196  Time 1312194744
<TZ_OK> RSSI 193  Time 1312194744
<TZ_OK> RSSI 197  Time 1312194744
<TZ_OK> RSSI 185  Time 1312194744
<TZ_OK> RSSI 191  Time 1312194744
<TZ_OK> RSSI 179  Time 1312194744
<TZ_OK> RSSI 189  Time 1312194744
<TZ_OK> RSSI 193  Time 1312194744
<TZ_OK> RSSI 191  Time 1312194744
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 190  Time 1312194750
<TZ_OK> RSSI 185  Time 1312194750
<TZ_OK> RSSI 185  Time 1312194750
<TZ_OK> RSSI 181  Time 1312194750
<TZ_OK> RSSI 188  Time 1312194750
<TZ_OK> RSSI 194  Time 1312194750
<TZ_OK> RSSI 197  Time 1312194750
<TZ_OK> RSSI 189  Time 1312194750
<TZ_OK> RSSI 188  Time 1312194750
<TZ_OK> RSSI 195  Time 1312194750
<TZ_OK> RSSI 177  Time 1312194751
<TZ_OK> RSSI 189  Time 1312194751
<TZ_OK> RSSI 192  Time 1312194751
<TZ_OK> RSSI 194  Time 1312194751
<TZ_OK> RSSI 176  Time 1312194751
<TZ_OK> RSSI 177  Time 1312194751
<TZ_OK> RSSI 192  Time 1312194751
<TZ_OK> RSSI 171  Time 1312194751
<TZ_OK> RSSI 191  Time 1312194751
<TZ_OK> RSSI 181  Time 1312194751
<TZ_OK> RSSI 187  Time 1312194751
<TZ_OK> RSSI 193  Time 1312194751
waiting for connection
<TZ_OK> RSSI 178  Time 1312194751
<TZ_OK> RSSI 189  Time 1312194751
<TZ_OK> RSSI 198  Time 1312194751
<TZ_OK> RSSI 187  Time 1312194752
<TZ_OK> RSSI 200  Time 1312194752
<TZ_OK> RSSI 193  Time 1312194752
<TZ_OK> RSSI 195  Time 1312194752
<TZ_OK> RSSI 189  Time 1312194752
<TZ_OK> RSSI 194  Time 1312194752
<TZ_OK> RSSI 198  Time 1312194752
<TZ_OK> RSSI 196  Time 1312194752
<TZ_OK> RSSI 183  Time 1312194752
<TZ_OK> RSSI 186  Time 1312194752
<TZ_OK> RSSI 193  Time 1312194752
<TZ_OK> RSSI 172  Time 1312194752
<TZ_OK> RSSI 193  Time 1312194752
<TZ_OK> RSSI 197  Time 1312194752
<TZ_OK> RSSI 188  Time 1312194753
<TZ_OK> RSSI 202  Time 1312194753
<TZ_OK> RSSI 177  Time 1312194753
<TZ_OK>waiting for connection
 RSSI 185  Time 1312194753
<TZ_OK> RSSI 187  Time 1312194753
<TZ_OK> RSSI 185  Time 1312194753
<TZ_OK> RSSI 191  Time 1312194753
<TZ_OK> RSSI 192  Time 1312194753
<TZ_OK> RSSI 189  Time 1312194754
<TZ_OK> RSSI 199  Time 1312194754
<TZ_OK> RSSI 191  Time 1312194754
<TZ_OK>waiting for connection
 RSSI 178  Time 1312194755
<TZ_OK> RSSI 192  Time 1312194756
<TZ_OK> RSSI 185  Time 1312194756
<TZ_OK>waiting for connection
 RSSI 169  Time 1312194756
<TZ_OK> RSSI 187  Time 1312194756
<TZ_OK> RSSI 190  Time 1312194756
<TZ_OK> RSSI 199  Time 1312194757
<TZ_OK> RSSI 183  Time 1312194757
<TZ_OK> RSSI 179  Time 1312194757
<TZ_OK> RSSI 195  Time 1312194757
<TZ_OK> RSSI 179  Time 1312194757
<TZ_OK>waiting for connection
 RSSI 194  Time 1312194757
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 195  Time 1312194763
<TZ_OK> RSSI 202  Time 1312194763
<TZ_OK> RSSI 197  Time 1312194763
<TZ_OK> RSSI 187  Time 1312194763
<TZ_OK> RSSI 193  Time 1312194763
<TZ_OK> RSSI 193  Time 1312194763
<TZ_OK> RSSI 177  Time 1312194763
<TZ_OK> RSSI 194  Time 1312194763
<TZ_OK> RSSI 197  Time 1312194763
waiting for connection
<TZ_OK> RSSI 192  Time 1312194763
<TZ_OK> RSSI 189  Time 1312194763
<TZ_OK> RSSI 186  Time 1312194763
<TZ_OK> RSSI 187  Time 1312194764
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 189  Time 1312194769
<TZ_OK> RSSI 177  Time 1312194769
<TZ_OK> RSSI 184  Time 1312194769
<TZ_OK> RSSI 189  Time 1312194769
<TZ_OK> RSSI 180  Time 1312194769
<TZ_OK> RSSI 192  Time 1312194769
<TZ_OK> RSSI 188  Time 1312194769
<TZ_OK> RSSI 181  Time 1312194769
<TZ_OK> RSSI 193  Time 1312194769
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 178  Time 1312194774
<TZ_OK> RSSI 190  Time 1312194775
<TZ_OK> RSSI 187  Time 1312194775
<TZ_OK> RSSI 187  Time 1312194775
<TZ_OK> RSSI 186  Time 1312194775
<TZ_OK> RSSI 199  Time 1312194775
<TZ_OK> RSSI 178  Time 1312194775
<TZ_OK> RSSI 173  Time 1312194775
<TZ_OK> RSSI 193  Time 1312194775
<TZ_OK> RSSI 187  Time 1312194775
<TZ_OK> RSSI 193  Time 1312194775
<TZ_OK> RSSI 194  Time 1312194775
waiting for connection
<TZ_OK> RSSI 185  Time 1312194775
<TZ_OK> RSSI 187  Time 1312194775
<TZ_OK> RSSI 187  Time 1312194775
<TZ_OK> RSSI 183  Time 1312194776
<TZ_OK> RSSI 188  Time 1312194776
<TZ_OK> RSSI 184  Time 1312194776
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 189  Time 1312194781
<TZ_OK> RSSI 187  Time 1312194781
<TZ_OK> RSSI 183  Time 1312194781
<TZ_OK> RSSI 176  Time 1312194781
<TZ_OK> RSSI 189  Time 1312194781
<TZ_OK> RSSI 183  Time 1312194781
<TZ_OK> RSSI 175  Time 1312194781
<TZ_OK> RSSI 200  Time 1312194781
waiting for connection
<TZ_OK> RSSI 199  Time 1312194781
<TZ_OK> RSSI 197  Time 1312194781
<TZ_OK> RSSI 180  Time 1312194781
<TZ_OK> RSSI 200  Time 1312194782
<TZ_OK> RSSI 198  Time 1312194782
<TZ_OK> RSSI 193  Time 1312194782
<TZ_OK> RSSI 182  Time 1312194782
<TZ_OK> RSSI 188  Time 1312194782
<TZ_OK> RSSI 193  Time 1312194782
<TZ_OK> RSSI 198  Time 1312194782
<TZ_OK> RSSI 190  Time 1312194782
<TZ_OK> RSSI 202  Time 1312194782
<TZ_OK> RSSI 187  Time 1312194782
<TZ_OK> RSSI 189  Time 1312194782
<TZ_OK> RSSI 182  Time 1312194782
<TZ_OK> RSSI 178  Time 1312194782
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 189  Time 1312194788
<TZ_OK> RSSI 193  Time 1312194788
<TZ_OK> RSSI 183  Time 1312194788
<TZ_OK> RSSI 191  Time 1312194788
<TZ_OK> RSSI 186  Time 1312194788
<TZ_OK> RSSI 191  Time 1312194788
<TZ_OK> RSSI 183  Time 1312194788
<TZ_OK> RSSI 193  Time 1312194788
<TZ_OK> RSSI 180  Time 1312194788
<TZ_OK> RSSI 187  Time 1312194788
<TZ_OK> RSSI 187  Time 1312194788
<TZ_OK> RSSI 184  Time 1312194788
<TZ_OK> RSSI 183  Time 1312194789
<TZ_OK> RSSI 195  Time 1312194789
<TZ_OK> RSSI 182  Time 1312194789
<TZ_OK> RSSI 189  Time 1312194789
<TZ_OK>waiting for connection
 RSSI 185  Time 1312194789
<TZ_OK> RSSI 190  Time 1312194789
<TZ_OK> RSSI 188  Time 1312194789
<TZ_OK> RSSI 186  Time 1312194789
<TZ_OK> RSSI 185  Time 1312194789
<TZ_OK> RSSI 187  Time 1312194789
<TZ_OK> RSSI 192  Time 1312194789
<TZ_OK> RSSI 193  Time 1312194789
<TZ_OK> RSSI 189  Time 1312194789
<TZ_OK> RSSI 189  Time 1312194789
<TZ_OK> RSSI 188  Time 1312194790
<TZ_OK> RSSI 176  Time 1312194790
<TZ_OK> RSSI 191  Time 1312194790
<TZ_OK> RSSI 186  Time 1312194790
<TZ_OK> RSSI 189  Time 1312194790
<TZ_OK> RSSI 192  Time 1312194790
<TZ_OK> RSSI 191  Time 1312194790
<TZ_OK> RSSI 178  Time 1312194790
<TZ_OK> RSSI 193  Time 1312194790
<TZ_OK> RSSI 198  Time 1312194790
<TZ_OK> RSSI 198  Time 1312194790
<TZ_OK> RSSI 189  Time 1312194790
waiting for connection
<TZ_OK> RSSI 196  Time 1312194790
<TZ_OK> RSSI 202  Time 1312194790
<TZ_OK> RSSI 198  Time 1312194790
<TZ_OK> RSSI 197  Time 1312194791
<TZ_OK> RSSI 194  Time 1312194791
<TZ_OK> RSSI 194  Time 1312194791
<TZ_OK> RSSI 186  Time 1312194791
<TZ_OK> RSSI 194  Time 1312194791
<TZ_OK> RSSI 184  Time 1312194791
<TZ_OK> RSSI 193  Time 1312194791
<TZ_OK> RSSI 196  Time 1312194791
<TZ_OK> RSSI 192  Time 1312194791
<TZ_OK> RSSI 178  Time 1312194791
<TZ_OK> RSSI 181  Time 1312194791
<TZ_OK> RSSI 185  Time 1312194791
<TZ_OK> RSSI 193  Time 1312194791
<TZ_OK> RSSI 196  Time 1312194791
<TZ_OK> RSSI 185  Time 1312194791
<TZ_OK> RSSI 191  Time 1312194792
<TZ_OK> RSSI 186  Time 1312194792
<TZ_OK> RSSI 178  Time 1312194792
<TZ_OK> RSSI 182  Time 1312194792
waiting for connection
<TZ_OK> RSSI 188  Time 1312194792
<TZ_OK> RSSI 180  Time 1312194792
<TZ_OK> RSSI 180  Time 1312194792
<TZ_OK> RSSI 183  Time 1312194792
<TZ_OK> RSSI 193  Time 1312194792
<TZ_OK> RSSI 198  Time 1312194792
<TZ_OK> RSSI 192  Time 1312194792
<TZ_OK> RSSI 193  Time 1312194792
<TZ_OK> RSSI 192  Time 1312194792
<TZ_OK> RSSI 183  Time 1312194792
<TZ_OK> RSSI 188  Time 1312194793
<TZ_OK> RSSI 193  Time 1312194793
<TZ_OK> RSSI 182  Time 1312194793
<TZ_OK> RSSI 181  Time 1312194793
<TZ_OK> RSSI 188  Time 1312194793
<TZ_OK> RSSI 195  Time 1312194793
<TZ_OK> RSSI 183  Time 1312194793
<TZ_OK> RSSI 186  Time 1312194793
<TZ_OK> RSSI 182  Time 1312194793
<TZ_OK> RSSI 192  Time 1312194793
<TZ_OK> RSSI 178  Time 1312194793
<TZ_OK> RSSI 194  Time 1312194793
waiting for connection
<TZ_OK> RSSI 198  Time 1312194793
<TZ_OK> RSSI 193  Time 1312194793
<TZ_OK> RSSI 191  Time 1312194793
<TZ_OK> RSSI 186  Time 1312194794
<TZ_OK> RSSI 175  Time 1312194794
<TZ_OK> RSSI 181  Time 1312194794
<TZ_OK> RSSI 195  Time 1312194794
<TZ_OK> RSSI 185  Time 1312194794
<TZ_OK> RSSI 200  Time 1312194794
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
waiting for connection
waiting for connection
<TZ_OK> RSSI 190  Time 1312194799
<TZ_OK> RSSI 192  Time 1312194799
<TZ_OK> RSSI 199  Time 1312194799
<TZ_OK> RSSI 191  Time 1312194799
<TZ_OK> RSSI 186  Time 1312194799
<TZ_OK> RSSI 177  Time 1312194800
<TZ_OK> RSSI 188  Time 1312194800
<TZ_OK> RSSI 189  Time 1312194800
<TZ_OK> RSSI 192  Time 1312194800
<TZ_OK> RSSI 188  Time 1312194800
<TZ_OK> RSSI 179  Time 1312194800
<TZ_OK> RSSI 198  Time 1312194800
waiting for connection
<TZ_OK> RSSI 197  Time 1312194800
<TZ_OK> RSSI 188  Time 1312194800
<TZ_OK> RSSI 189  Time 1312194800
<TZ_OK> RSSI 197  Time 1312194800
<TZ_OK> RSSI 180  Time 1312194800
<TZ_OK> RSSI 173  Time 1312194800
<TZ_OK> RSSI 185  Time 1312194800
<TZ_OK> RSSI 181  Time 1312194800
<TZ_OK> RSSI 183  Time 1312194801
<TZ_OK> RSSI 187  Time 1312194801
<TZ_OK> RSSI 188  Time 1312194801
<TZ_OK> RSSI 174  Time 1312194801
<TZ_OK> RSSI 189  Time 1312194801
<TZ_OK> RSSI 192  Time 1312194801
<TZ_OK> RSSI 182  Time 1312194801
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
<TZ_OK> RSSI 181  Time 1312194801
<TZ_OK> RSSI 183  Time 1312194801
<TZ_OK> RSSI 189  Time 1312194801
<TZ_OK> RSSI 183  Time 1312194801
<TZ_OK> RSSI 193  Time 1312194801
<TZ_OK> RSSI 188  Time 1312194801
<TZ_OK> RSSI 180  Time 1312194801
<TZ_OK> RSSI 194  Time 1312194802
<TZ_OK> RSSI 186  Time 1312194802
<TZ_OK> RSSI 194  Time 1312194802
<TZ_OK> RSSI 197  Time 1312194802
<TZ_OK> RSSI 197  Time 1312194802
<TZ_OK> RSSI 185  Time 1312194802
<TZ_OK> RSSI 183  Time 1312194802
<TZ_OK> RSSI 186  Time 1312194802
<TZ_OK> RSSI 178  Time 1312194802
<TZ_OK> RSSI 189  Time 1312194802
<TZ_OK> RSSI 191  Time 1312194802
<TZ_OK> RSSI 195  Time 1312194802
<TZ_OK> RSSI 192  Time 1312194802
<TZ_OK> RSSI 201  Time 1312194802
waiting for connection
<TZ_OK> RSSI 188  Time 1312194803
<TZ_OK> RSSI 187  Time 1312194803
<TZ_OK> RSSI 179  Time 1312194803
<TZ_OK> RSSI 192  Time 1312194803
<TZ_OK> RSSI 200  Time 1312194803
<TZ_OK> RSSI 199  Time 1312194803
<TZ_OK> RSSI 193  Time 1312194803
<TZ_OK> RSSI 180  Time 1312194803
<TZ_OK> RSSI 189  Time 1312194803
<TZ_OK> RSSI 182  Time 1312194803
<TZ_OK> RSSI 195  Time 1312194803
<TZ_OK> RSSI 187  Time 1312194803
<TZ_OK> RSSI 193  Time 1312194803
<TZ_OK> RSSI 188  Time 1312194803
<TZ_OK> RSSI 189  Time 1312194804
<TZ_OK> RSSI 190  Time 1312194804
<TZ_OK> RSSI 183  Time 1312194804
<TZ_OK> RSSI 188  Time 1312194804
<TZ_OK> RSSI 176  Time 1312194804
<TZ_OK> RSSI 187  Time 1312194804
<TZ_OK> RSSI 187  Time 1312194804
<TZ_OK> RSSI 192  Time 1312194804
waiting for connection
<TZ_OK> RSSI 185  Time 1312194804
<TZ_OK> RSSI 178  Time 1312194804
<TZ_OK> RSSI 194  Time 1312194804
<TZ_OK> RSSI 186  Time 1312194804
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
waiting for connection
<TZ_OK> RSSI 189  Time 1312194809
<TZ_OK> RSSI 182  Time 1312194809
<TZ_OK> RSSI 193  Time 1312194809
waiting for connection
<TZ_OK> RSSI 186  Time 1312194810
<TZ_OK> RSSI 188  Time 1312194810
<TZ_OK> RSSI 193  Time 1312194810
<TZ_OK> RSSI 191  Time 1312194810
<TZ_OK> RSSI 194  Time 1312194810
<TZ_OK> RSSI 188  Time 1312194810
<TZ_OK> RSSI 185  Time 1312194810
<TZ_OK> RSSI 195  Time 1312194810
<TZ_OK> RSSI 192  Time 1312194810
<TZ_OK> RSSI 203  Time 1312194810
<TZ_OK> RSSI 188  Time 1312194810
<TZ_OK> RSSI 185  Time 1312194810
<TZ_OK> RSSI 187  Time 1312194810
<TZ_OK> RSSI 198  Time 1312194810
<TZ_OK> RSSI 190  Time 1312194811
<TZ_OK> RSSI 193  Time 1312194811
<TZ_OK> RSSI 186  Time 1312194811
<TZ_OK> RSSI 201  Time 1312194811
<TZ_OK> RSSI 192  Time 1312194811
<TZ_OK> RSSI 182  Time 1312194811
<TZ_OK> RSSI 198  Time 1312194811
<TZ_OK> RSSI 193  Time 1312194811
waiting for connection
<TZ_OK> RSSI 192  Time 1312194811
<TZ_OK> RSSI 198  Time 1312194811
<TZ_OK> RSSI 193  Time 1312194811
<TZ_OK> RSSI 183  Time 1312194811
<TZ_OK> RSSI 179  Time 1312194811
<TZ_OK> RSSI 190  Time 1312194811
<TZ_OK>accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
Inquiry
waiting for connection
Starting inquiry with RSSI...
thread end
 RSSI 189  Time 1312194812
<TZ_OK> RSSI 198  Time 1312194813
<TZ_OK> RSSI 200  Time 1312194813
<TZ_OK> RSSI 187  Time 1312194813
<TZ_OK> RSSI 195  Time 1312194813
<TZ_OK> RSSI 199  Time 1312194814
waiting for connection
<TZ_OK> RSSI 192  Time 1312194814
<TZ_OK> RSSI 203  Time 1312194814
<TZ_OK> RSSI 192  Time 1312194814
<TZ_OK> RSSI 195  Time 1312194814
<TZ_OK> RSSI 192  Time 1312194814
<TZ_OK> RSSI 181  Time 1312194815
<TZ_OK> RSSI 199  Time 1312194815
<TZ_OK> RSSI 184  Time 1312194815
<TZ_OK> RSSI 199  Time 1312194815
<TZ_OK>waiting for connection
 RSSI 184  Time 1312194815
<TZ_OK> RSSI 186  Time 1312194815
<TZ_OK> RSSI 194  Time 1312194815
<TZ_OK> RSSI 194  Time 1312194816
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 194  Time 1312194821
<TZ_OK> RSSI 178  Time 1312194821
waiting for connection
<TZ_OK> RSSI 183  Time 1312194821
<TZ_OK> RSSI 187  Time 1312194821
<TZ_OK> RSSI 188  Time 1312194821
<TZ_OK> RSSI 183  Time 1312194821
<TZ_OK> RSSI 189  Time 1312194821
<TZ_OK> RSSI 183  Time 1312194821
<TZ_OK> RSSI 180  Time 1312194822
<TZ_OK> RSSI 186  Time 1312194822
<TZ_OK> RSSI 191  Time 1312194822
<TZ_OK> RSSI 189  Time 1312194822
<TZ_OK> RSSI 175  Time 1312194822
<TZ_OK> RSSI 193  Time 1312194822
<TZ_OK> RSSI 188  Time 1312194822
<TZ_OK> RSSI 189  Time 1312194822
<TZ_OK> RSSI 180  Time 1312194822
<TZ_OK> RSSI 177  Time 1312194822
<TZ_OK> RSSI 194  Time 1312194822
<TZ_OK> RSSI 180  Time 1312194822
<TZ_OK> RSSI 188  Time 1312194822
<TZ_OK> RSSI 199  Time 1312194822
<TZ_OK> RSSI 189  Time 1312194823
<TZ_OK> RSSI 188  Time 1312194823
waiting for connection
<TZ_OK> RSSI 194  Time 1312194823
<TZ_OK> RSSI 194  Time 1312194823
<TZ_OK> RSSI 195  Time 1312194823
<TZ_OK> RSSI 193  Time 1312194823
<TZ_OK> RSSI 186  Time 1312194823
<TZ_OK> RSSI 192  Time 1312194823
<TZ_OK> RSSI 191  Time 1312194823
<TZ_OK> RSSI 192  Time 1312194823
<TZ_OK> RSSI 196  Time 1312194823
<TZ_OK> RSSI 192  Time 1312194823
<TZ_OK> RSSI 184  Time 1312194823
<TZ_OK> RSSI 193  Time 1312194823
<TZ_OK> RSSI 192  Time 1312194823
<TZ_OK> RSSI 190  Time 1312194824
<TZ_OK> RSSI 179  Time 1312194824
<TZ_OK> RSSI 179  Time 1312194824
<TZ_OK> RSSI 186  Time 1312194824
<TZ_OK> RSSI 186  Time 1312194824
<TZ_OK> RSSI 183  Time 1312194824
<TZ_OK> RSSI 192  Time 1312194824
<TZ_OK> RSSI 181  Time 1312194824
waiting for connection
<TZ_OK> RSSI 182  Time 1312194824
<TZ_OK> RSSI 189  Time 1312194824
<TZ_OK> RSSI 177  Time 1312194824
<TZ_OK> RSSI 178  Time 1312194824
<TZ_OK> RSSI 179  Time 1312194824
<TZ_OK> RSSI 198  Time 1312194824
<TZ_OK> RSSI 187  Time 1312194825
<TZ_OK> RSSI 187  Time 1312194825
<TZ_OK> RSSI 192  Time 1312194825
<TZ_OK> RSSI 186  Time 1312194825
<TZ_OK> RSSI 189  Time 1312194825
<TZ_OK> RSSI 186  Time 1312194825
<TZ_OK> RSSI 198  Time 1312194825
<TZ_OK> RSSI 183  Time 1312194825
<TZ_OK> RSSI 196  Time 1312194825
<TZ_OK> RSSI 193  Time 1312194825
<TZ_OK> RSSI 198  Time 1312194825
<TZ_OK> RSSI 190  Time 1312194825
<TZ_OK> RSSI 187  Time 1312194825
<TZ_OK> RSSI 188  Time 1312194825
<TZ_OK> RSSI 195  Time 1312194825
<TZ_OK> RSSI 187  Time 1312194826
waiting for connection
<TZ_OK> RSSI 179  Time 1312194826
<TZ_OK> RSSI 178  Time 1312194826
<TZ_OK> RSSI 193  Time 1312194826
<TZ_OK> RSSI 188  Time 1312194826
<TZ_OK> RSSI 182  Time 1312194826
<TZ_OK> RSSI 190  Time 1312194826
<TZ_OK> RSSI 193  Time 1312194826
<TZ_OK> RSSI 192  Time 1312194826
<TZ_OK> RSSI 193  Time 1312194826
<TZ_OK> RSSI 181  Time 1312194826
<TZ_OK> RSSI 187  Time 1312194826
<TZ_OK> RSSI 198  Time 1312194826
<TZ_OK> RSSI 192  Time 1312194826
<TZ_OK> RSSI 194  Time 1312194827
<TZ_OK> RSSI 201  Time 1312194827
<TZ_OK> RSSI 191  Time 1312194827
<TZ_OK> RSSI 199  Time 1312194827
<TZ_OK>waiting for connection
 RSSI 199  Time 1312194827
<TZ_OK> RSSI 199  Time 1312194827
<TZ_OK> RSSI 177  Time 1312194828
<TZ_OK> RSSI 183  Time 1312194828
<TZ_OK> RSSI 182  Time 1312194828
<TZ_OK> RSSI 187  Time 1312194828
<TZ_OK> RSSI 173  Time 1312194828
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 191  Time 1312194833
<TZ_OK> RSSI 187  Time 1312194833
<TZ_OK> RSSI 186  Time 1312194833
<TZ_OK> RSSI 188  Time 1312194833
<TZ_OK> RSSI 186  Time 1312194833
<TZ_OK> RSSI 185  Time 1312194834
<TZ_OK> RSSI 186  Time 1312194834
<TZ_OK> RSSI 183  Time 1312194834
<TZ_OK> RSSI 192  Time 1312194834
<TZ_OK> RSSI 187  Time 1312194834
<TZ_OK> RSSI 187  Time 1312194834
<TZ_OK> RSSI 185  Time 1312194834
<TZ_OK> RSSI 200  Time 1312194834
<TZ_OK> RSSI 181  Time 1312194834
<TZ_OK> RSSI 189  Time 1312194834
<TZ_OK> RSSI 183  Time 1312194834
<TZ_OK> RSSI 188  Time 1312194834
<TZ_OK> RSSI 185  Time 1312194834
<TZ_OK> RSSI 199  Time 1312194834
<TZ_OK> RSSI 192  Time 1312194834
<TZ_OK> RSSI 189  Time 1312194835
waiting for connection
<TZ_OK> RSSI 177  Time 1312194835
<TZ_OK> RSSI 175  Time 1312194835
<TZ_OK> RSSI 193  Time 1312194835
<TZ_OK> RSSI 189  Time 1312194835
<TZ_OK> RSSI 187  Time 1312194835
<TZ_OK> RSSI 191  Time 1312194835
<TZ_OK> RSSI 199  Time 1312194835
<TZ_OK> RSSI 187  Time 1312194835
<TZ_OK> RSSI 200  Time 1312194835
<TZ_OK> RSSI 179  Time 1312194835
<TZ_OK> RSSI 199  Time 1312194835
<TZ_OK> RSSI 189  Time 1312194835
<TZ_OK> RSSI 184  Time 1312194835
<TZ_OK> RSSI 182  Time 1312194836
<TZ_OK> RSSI 187  Time 1312194836
<TZ_OK> RSSI 192  Time 1312194836
<TZ_OK> RSSI 199  Time 1312194836
<TZ_OK> RSSI 185  Time 1312194836
<TZ_OK> RSSI 201  Time 1312194836
<TZ_OK> RSSI 188  Time 1312194836
<TZ_OK> RSSI 183  Time 1312194836
waiting for connection
<TZ_OK> RSSI 186  Time 1312194836
<TZ_OK> RSSI 190  Time 1312194836
<TZ_OK> RSSI 197  Time 1312194836
<TZ_OK> RSSI 190  Time 1312194836
<TZ_OK> RSSI 187  Time 1312194836
<TZ_OK> RSSI 180  Time 1312194836
<TZ_OK> RSSI 183  Time 1312194837
<TZ_OK> RSSI 180  Time 1312194837
<TZ_OK> RSSI 183  Time 1312194837
<TZ_OK> RSSI 186  Time 1312194837
<TZ_OK> RSSI 179  Time 1312194837
<TZ_OK> RSSI 188  Time 1312194837
<TZ_OK> RSSI 181  Time 1312194837
<TZ_OK> RSSI 178  Time 1312194837
<TZ_OK> RSSI 179  Time 1312194837
<TZ_OK> RSSI 187  Time 1312194837
<TZ_OK> RSSI 176  Time 1312194837
<TZ_OK> RSSI 193  Time 1312194837
<TZ_OK> RSSI 187  Time 1312194837
<TZ_OK> RSSI 181  Time 1312194838
<TZ_OK> RSSI 189  Time 1312194838
waiting for connection
<TZ_OK> RSSI 193  Time 1312194838
<TZ_OK> RSSI 193  Time 1312194838
<TZ_OK> RSSI 197  Time 1312194838
<TZ_OK> RSSI 186  Time 1312194838
<TZ_OK> RSSI 189  Time 1312194838
<TZ_OK> RSSI 191  Time 1312194838
<TZ_OK> RSSI 188  Time 1312194838
<TZ_OK> RSSI 174  Time 1312194838
<TZ_OK> RSSI 193  Time 1312194838
<TZ_OK> RSSI 195  Time 1312194838
<TZ_OK> RSSI 175  Time 1312194838
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 192  Time 1312194843
<TZ_OK> RSSI 183  Time 1312194843
<TZ_OK> RSSI 192  Time 1312194844
waiting for connection
<TZ_OK> RSSI 189  Time 1312194844
<TZ_OK> RSSI 191  Time 1312194844
<TZ_OK> RSSI 185  Time 1312194844
<TZ_OK> RSSI 189  Time 1312194844
<TZ_OK> RSSI 195  Time 1312194844
<TZ_OK> RSSI 189  Time 1312194844
<TZ_OK> RSSI 184  Time 1312194844
<TZ_OK> RSSI 189  Time 1312194844
<TZ_OK> RSSI 198  Time 1312194844
<TZ_OK> RSSI 193  Time 1312194844
<TZ_OK> RSSI 188  Time 1312194844
<TZ_OK> RSSI 180  Time 1312194844
<TZ_OK> RSSI 186  Time 1312194844
<TZ_OK> RSSI 189  Time 1312194845
<TZ_OK> RSSI 190  Time 1312194845
<TZ_OK> RSSI 189  Time 1312194845
<TZ_OK> RSSI 190  Time 1312194845
<TZ_OK> RSSI 187  Time 1312194845
<TZ_OK> RSSI 199  Time 1312194845
<TZ_OK> RSSI 199  Time 1312194845
<TZ_OK> RSSI 170  Time 1312194845
<TZ_OK> RSSI 193  Time 1312194845
waiting for connection
<TZ_OK> RSSI 186  Time 1312194845
<TZ_OK> RSSI 195  Time 1312194845
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 189  Time 1312194850
<TZ_OK> RSSI 173  Time 1312194850
<TZ_OK> RSSI 182  Time 1312194850
<TZ_OK> RSSI 185  Time 1312194851
<TZ_OK> RSSI 183  Time 1312194851
<TZ_OK> RSSI 194  Time 1312194851
<TZ_OK> RSSI 177  Time 1312194851
<TZ_OK> RSSI 182  Time 1312194851
<TZ_OK> RSSI 170  Time 1312194851
<TZ_OK> RSSI 187  Time 1312194851
<TZ_OK> RSSI 191  Time 1312194851
<TZ_OK> RSSI 180  Time 1312194851
waiting for connection
<TZ_OK> RSSI 181  Time 1312194851
<TZ_OK> RSSI 193  Time 1312194851
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 176  Time 1312194856
<TZ_OK> RSSI 185  Time 1312194856
<TZ_OK> RSSI 192  Time 1312194856
<TZ_OK> RSSI 197  Time 1312194857
<TZ_OK> RSSI 190  Time 1312194857
<TZ_OK> RSSI 181  Time 1312194857
<TZ_OK> RSSI 192  Time 1312194857
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 198  Time 1312194862
<TZ_OK> RSSI 186  Time 1312194862
<TZ_OK> RSSI 188  Time 1312194862
<TZ_OK> RSSI 191  Time 1312194862
<TZ_OK> RSSI 191  Time 1312194862
<TZ_OK> RSSI 190  Time 1312194862
<TZ_OK> RSSI 198  Time 1312194862
<TZ_OK> RSSI 182  Time 1312194862
<TZ_OK> RSSI 186  Time 1312194862
<TZ_OK> RSSI 190  Time 1312194862
<TZ_OK> RSSI 194  Time 1312194863
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 200  Time 1312194868
waiting for connection
<TZ_OK> RSSI 186  Time 1312194868
<TZ_OK> RSSI 183  Time 1312194868
<TZ_OK> RSSI 192  Time 1312194868
<TZ_OK> RSSI 198  Time 1312194868
<TZ_OK> RSSI 191  Time 1312194868
<TZ_OK> RSSI 187  Time 1312194868
<TZ_OK> RSSI 201  Time 1312194868
<TZ_OK> RSSI 189  Time 1312194868
<TZ_OK> RSSI 185  Time 1312194868
<TZ_OK> RSSI 187  Time 1312194868
<TZ_OK> RSSI 188  Time 1312194868
<TZ_OK> RSSI 190  Time 1312194868
<TZ_OK> RSSI 182  Time 1312194869
<TZ_OK> RSSI 196  Time 1312194869
<TZ_OK> RSSI 192  Time 1312194869
<TZ_OK> RSSI 192  Time 1312194869
<TZ_OK> RSSI 191  Time 1312194869
<TZ_OK> RSSI 194  Time 1312194869
<TZ_OK> RSSI 193  Time 1312194869
<TZ_OK> RSSI 192  Time 1312194869
<TZ_OK> RSSI 188  Time 1312194869
waiting for connection
<TZ_OK> RSSI 192  Time 1312194869
<TZ_OK> RSSI 184  Time 1312194869
<TZ_OK> RSSI 178  Time 1312194869
<TZ_OK> RSSI 188  Time 1312194869
<TZ_OK> RSSI 177  Time 1312194869
<TZ_OK> RSSI 176  Time 1312194869
<TZ_OK> RSSI 201  Time 1312194870
<TZ_OK> RSSI 185  Time 1312194870
<TZ_OK> RSSI 183  Time 1312194870
<TZ_OK> RSSI 188  Time 1312194870
<TZ_OK> RSSI 181  Time 1312194870
<TZ_OK> RSSI 181  Time 1312194870
<TZ_OK> RSSI 180  Time 1312194870
<TZ_OK> RSSI 174  Time 1312194870
<TZ_OK> RSSI 196  Time 1312194870
<TZ_OK> RSSI 182  Time 1312194870
<TZ_OK> RSSI 175  Time 1312194870
<TZ_OK> RSSI 177  Time 1312194870
<TZ_OK> RSSI 179  Time 1312194870
<TZ_OK> RSSI 182  Time 1312194870
<TZ_OK> RSSI 193  Time 1312194871
<TZ_OK> RSSI 186  Time 1312194871
waiting for connection
<TZ_OK> RSSI 191  Time 1312194871
<TZ_OK> RSSI 198  Time 1312194871
<TZ_OK> RSSI 188  Time 1312194871
<TZ_OK> RSSI 182  Time 1312194871
<TZ_OK> RSSI 192  Time 1312194871
<TZ_OK> RSSI 188  Time 1312194871
<TZ_OK> RSSI 185  Time 1312194871
<TZ_OK> RSSI 177  Time 1312194871
<TZ_OK> RSSI 182  Time 1312194871
<TZ_OK> RSSI 197  Time 1312194871
<TZ_OK> RSSI 176  Time 1312194871
<TZ_OK> RSSI 179  Time 1312194871
<TZ_OK> RSSI 182  Time 1312194872
<TZ_OK> RSSI 181  Time 1312194872
<TZ_OK> RSSI 187  Time 1312194872
<TZ_OK> RSSI 182  Time 1312194872
<TZ_OK> RSSI 187  Time 1312194872
<TZ_OK> RSSI 179  Time 1312194872
<TZ_OK> RSSI 189  Time 1312194872
<TZ_OK> RSSI 188  Time 1312194872
<TZ_OK> RSSI 191  Time 1312194872
waiting for connection
<TZ_OK> RSSI 177  Time 1312194872
<TZ_OK> RSSI 179  Time 1312194872
<TZ_OK> RSSI 195  Time 1312194872
<TZ_OK> RSSI 186  Time 1312194872
<TZ_OK> RSSI 189  Time 1312194872
<TZ_OK> RSSI 196  Time 1312194873
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
waiting for connection
waiting for connection
<TZ_OK> RSSI 188  Time 1312194878
<TZ_OK> RSSI 188  Time 1312194878
<TZ_OK> RSSI 195  Time 1312194878
<TZ_OK> RSSI 191  Time 1312194878
<TZ_OK> RSSI 183  Time 1312194878
<TZ_OK> RSSI 189  Time 1312194878
<TZ_OK> RSSI 191  Time 1312194878
<TZ_OK> RSSI 195  Time 1312194878
<TZ_OK> RSSI 182  Time 1312194878
<TZ_OK> RSSI 197  Time 1312194878
<TZ_OK> RSSI 190  Time 1312194878
<TZ_OK> RSSI 187  Time 1312194878
<TZ_OK> RSSI 197  Time 1312194878
<TZ_OK> RSSI 179  Time 1312194879
<TZ_OK> RSSI 193  Time 1312194879
<TZ_OK> RSSI 183  Time 1312194879
<TZ_OK> RSSI 198  Time 1312194879
<TZ_OK> RSSI 189  Time 1312194879
<TZ_OK> RSSI 194  Time 1312194879
<TZ_OK> RSSI 193  Time 1312194879
waiting for connection
<TZ_OK> RSSI 189  Time 1312194879
<TZ_OK> RSSI 192  Time 1312194879
<TZ_OK> RSSI 193  Time 1312194879
<TZ_OK> RSSI 190  Time 1312194879
<TZ_OK> RSSI 189  Time 1312194879
<TZ_OK> RSSI 182  Time 1312194879
<TZ_OK> RSSI 192  Time 1312194879
<TZ_OK> RSSI 195  Time 1312194880
<TZ_OK> RSSI 191  Time 1312194880
<TZ_OK> RSSI 196  Time 1312194880
<TZ_OK> RSSI 187  Time 1312194880
<TZ_OK> RSSI 192  Time 1312194880
<TZ_OK> RSSI 187  Time 1312194880
<TZ_OK> RSSI 188  Time 1312194880
<TZ_OK> RSSI 191  Time 1312194880
<TZ_OK> RSSI 191  Time 1312194880
<TZ_OK> RSSI 188  Time 1312194880
<TZ_OK> RSSI 181  Time 1312194880
<TZ_OK> RSSI 194  Time 1312194880
<TZ_OK> RSSI 194  Time 1312194880
<TZ_OK> RSSI 192  Time 1312194880
waiting for connection
<TZ_OK> RSSI 191  Time 1312194881
<TZ_OK> RSSI 193  Time 1312194881
<TZ_OK> RSSI 193  Time 1312194881
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 194  Time 1312194886
<TZ_OK> RSSI 187  Time 1312194886
<TZ_OK> RSSI 192  Time 1312194886
<TZ_OK> RSSI 192  Time 1312194886
<TZ_OK> RSSI 176  Time 1312194886
<TZ_OK> RSSI 190  Time 1312194886
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
<TZ_OK> RSSI 188  Time 1312194887
<TZ_OK> RSSI 184  Time 1312194887
<TZ_OK> RSSI 198  Time 1312194887
<TZ_OK> RSSI 196  Time 1312194887
<TZ_OK> RSSI 195  Time 1312194887
<TZ_OK> RSSI 193  Time 1312194887
<TZ_OK> RSSI 189  Time 1312194887
<TZ_OK> RSSI 178  Time 1312194887
<TZ_OK> RSSI 184  Time 1312194887
<TZ_OK> RSSI 178  Time 1312194887
<TZ_OK> RSSI 192  Time 1312194887
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 186  Time 1312194892
<TZ_OK> RSSI 193  Time 1312194892
<TZ_OK> RSSI 191  Time 1312194892
waiting for connection
<TZ_OK> RSSI 197  Time 1312194893
<TZ_OK> RSSI 201  Time 1312194893
<TZ_OK> RSSI 192  Time 1312194893
<TZ_OK> RSSI 198  Time 1312194893
<TZ_OK> RSSI 186  Time 1312194893
<TZ_OK> RSSI 180  Time 1312194893
<TZ_OK> RSSI 183  Time 1312194893
<TZ_OK> RSSI 186  Time 1312194893
<TZ_OK> RSSI 177  Time 1312194893
<TZ_OK> RSSI 181  Time 1312194893
<TZ_OK> RSSI 188  Time 1312194893
<TZ_OK> RSSI 180  Time 1312194893
<TZ_OK> RSSI 176  Time 1312194893
<TZ_OK> RSSI 182  Time 1312194893
<TZ_OK> RSSI 179  Time 1312194894
<TZ_OK> RSSI 184  Time 1312194894
<TZ_OK> RSSI 193  Time 1312194894
<TZ_OK> RSSI 191  Time 1312194894
<TZ_OK> RSSI 174  Time 1312194894
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 196  Time 1312194899
<TZ_OK> RSSI 192  Time 1312194899
<TZ_OK> RSSI 194  Time 1312194899
<TZ_OK> RSSI 195  Time 1312194899
<TZ_OK> RSSI 192  Time 1312194899
<TZ_OK> RSSI 186  Time 1312194899
<TZ_OK> RSSI 188  Time 1312194899
<TZ_OK> RSSI 187  Time 1312194899
<TZ_OK> RSSI 191  Time 1312194899
<TZ_OK> RSSI 186  Time 1312194899
<TZ_OK> RSSI 187  Time 1312194900
<TZ_OK> RSSI 196  Time 1312194900
<TZ_OK> RSSI 184  Time 1312194900
<TZ_OK> RSSI 189  Time 1312194900
<TZ_OK> RSSI 181  Time 1312194900
<TZ_OK> RSSI 197  Time 1312194900
waiting for connection
<TZ_OK> RSSI 198  Time 1312194900
<TZ_OK> RSSI 187  Time 1312194900
<TZ_OK> RSSI 191  Time 1312194900
<TZ_OK> RSSI 198  Time 1312194900
<TZ_OK> RSSI 192  Time 1312194900
<TZ_OK> RSSI 189  Time 1312194900
<TZ_OK> RSSI 197  Time 1312194900
<TZ_OK> RSSI 190  Time 1312194900
<TZ_OK> RSSI 187  Time 1312194901
<TZ_OK> RSSI 196  Time 1312194901
<TZ_OK> RSSI 187  Time 1312194901
<TZ_OK> RSSI 193  Time 1312194901
<TZ_OK> RSSI 190  Time 1312194901
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
<TZ_OK> RSSI 189  Time 1312194901
<TZ_OK> RSSI 187  Time 1312194901
<TZ_OK> RSSI 185  Time 1312194901
<TZ_OK>waiting for connection
waiting for connection
waiting for connection
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
Inquiry
waiting for connection
Starting inquiry with RSSI...
thread end
 RSSI 191  Time 1312194908
<TZ_OK> RSSI 185  Time 1312194909
<TZ_OK>waiting for connection
 RSSI 176  Time 1312194910
<TZ_OK> RSSI 185  Time 1312194910
<TZ_OK> RSSI 183  Time 1312194911
<TZ_OK> RSSI 193  Time 1312194911
waiting for connection
<TZ_OK> RSSI 181  Time 1312194911
<TZ_OK> RSSI 192  Time 1312194912
<TZ_OK> RSSI 198  Time 1312194912
<TZ_OK> RSSI 189  Time 1312194912
<TZ_OK> RSSI 190  Time 1312194912
<TZ_OK> RSSI 193  Time 1312194912
<TZ_OK> RSSI 177  Time 1312194912
<TZ_OK> RSSI 192  Time 1312194912
<TZ_OK> RSSI 188  Time 1312194913
waiting for connection
<TZ_OK> RSSI 192  Time 1312194913
<TZ_OK> RSSI 181  Time 1312194913
<TZ_OK> RSSI 191  Time 1312194913
<TZ_OK> RSSI 184  Time 1312194914
waiting for connection
<TZ_OK> RSSI 199  Time 1312194914
<TZ_OK> RSSI 189  Time 1312194914
<TZ_OK> RSSI 198  Time 1312194915
<TZ_OK> RSSI 188  Time 1312194915
<TZ_OK> RSSI 190  Time 1312194915
<TZ_OK> RSSI 191  Time 1312194915
<TZ_OK> RSSI 190  Time 1312194915
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 191  Time 1312194920
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 186  Time 1312194925
<TZ_OK> RSSI 190  Time 1312194925
<TZ_OK> RSSI 187  Time 1312194925
<TZ_OK> RSSI 187  Time 1312194925
<TZ_OK> RSSI 186  Time 1312194926
<TZ_OK> RSSI 188  Time 1312194926
<TZ_OK> RSSI 183  Time 1312194926
<TZ_OK> RSSI 191  Time 1312194926
<TZ_OK> RSSI 196  Time 1312194926
<TZ_OK> RSSI 173  Time 1312194926
<TZ_OK> RSSI 195  Time 1312194926
<TZ_OK> RSSI 189  Time 1312194926
<TZ_OK> RSSI 183  Time 1312194926
<TZ_OK> RSSI 195  Time 1312194926
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 195  Time 1312194931
<TZ_OK> RSSI 190  Time 1312194931
<TZ_OK> RSSI 186  Time 1312194931
<TZ_OK> RSSI 189  Time 1312194931
<TZ_OK> RSSI 188  Time 1312194932
<TZ_OK> RSSI 186  Time 1312194932
<TZ_OK> RSSI 192  Time 1312194932
<TZ_OK> RSSI 181  Time 1312194932
<TZ_OK> RSSI 201  Time 1312194932
<TZ_OK> RSSI 181  Time 1312194932
<TZ_OK> RSSI 198  Time 1312194932
<TZ_OK> RSSI 186  Time 1312194932
<TZ_OK> RSSI 185  Time 1312194932
<TZ_OK> RSSI 189  Time 1312194932
<TZ_OK> RSSI 182  Time 1312194932
<TZ_OK> RSSI 179  Time 1312194932
waiting for connection
<TZ_OK> RSSI 176  Time 1312194932
<TZ_OK> RSSI 184  Time 1312194932
<TZ_OK> RSSI 187  Time 1312194933
<TZ_OK> RSSI 184  Time 1312194933
<TZ_OK> RSSI 189  Time 1312194933
<TZ_OK> RSSI 181  Time 1312194933
<TZ_OK> RSSI 191  Time 1312194933
<TZ_OK> RSSI 181  Time 1312194933
<TZ_OK> RSSI 178  Time 1312194933
<TZ_OK> RSSI 191  Time 1312194933
<TZ_OK> RSSI 187  Time 1312194933
<TZ_OK> RSSI 174  Time 1312194933
<TZ_OK> RSSI 189  Time 1312194933
<TZ_OK> RSSI 180  Time 1312194933
<TZ_OK> RSSI 185  Time 1312194933
<TZ_OK> RSSI 186  Time 1312194934
<TZ_OK> RSSI 188  Time 1312194934
<TZ_OK> RSSI 192  Time 1312194934
<TZ_OK> RSSI 198  Time 1312194934
waiting for connection
<TZ_OK> RSSI 189  Time 1312194934
<TZ_OK> RSSI 185  Time 1312194934
<TZ_OK> RSSI 196  Time 1312194934
<TZ_OK> RSSI 192  Time 1312194934
<TZ_OK> RSSI 191  Time 1312194934
<TZ_OK> RSSI 199  Time 1312194934
<TZ_OK> RSSI 188  Time 1312194934
<TZ_OK> RSSI 192  Time 1312194934
<TZ_OK> RSSI 186  Time 1312194934
<TZ_OK> RSSI 191  Time 1312194934
<TZ_OK> RSSI 192  Time 1312194935
<TZ_OK> RSSI 193  Time 1312194935
<TZ_OK> RSSI 194  Time 1312194935
<TZ_OK> RSSI 192  Time 1312194935
<TZ_OK> RSSI 188  Time 1312194935
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 187  Time 1312194940
<TZ_OK> RSSI 189  Time 1312194940
<TZ_OK> RSSI 192  Time 1312194940
<TZ_OK> RSSI 184  Time 1312194940
<TZ_OK> RSSI 180  Time 1312194940
<TZ_OK> RSSI 191  Time 1312194940
<TZ_OK> RSSI 191  Time 1312194940
<TZ_OK> RSSI 192  Time 1312194940
<TZ_OK> RSSI 180  Time 1312194940
<TZ_OK> RSSI 193  Time 1312194941
<TZ_OK> RSSI 192  Time 1312194941
<TZ_OK> RSSI 175  Time 1312194941
<TZ_OK> RSSI 192  Time 1312194941
<TZ_OK> RSSI 189  Time 1312194941
<TZ_OK> RSSI 185  Time 1312194941
<TZ_OK> RSSI 191  Time 1312194941
<TZ_OK> RSSI 186  Time 1312194941
<TZ_OK> RSSI 182  Time 1312194941
<TZ_OK> RSSI 187  Time 1312194941
<TZ_OK> RSSI 190  Time 1312194941
<TZ_OK> RSSI 193  Time 1312194941
waiting for connection
<TZ_OK> RSSI 175  Time 1312194941
<TZ_OK> RSSI 193  Time 1312194941
<TZ_OK> RSSI 189  Time 1312194942
<TZ_OK> RSSI 190  Time 1312194942
<TZ_OK> RSSI 190  Time 1312194942
<TZ_OK> RSSI 186  Time 1312194942
<TZ_OK> RSSI 193  Time 1312194942
<TZ_OK> RSSI 188  Time 1312194942
<TZ_OK> RSSI 181  Time 1312194942
<TZ_OK> RSSI 185  Time 1312194942
<TZ_OK> RSSI 193  Time 1312194942
<TZ_OK> RSSI 197  Time 1312194942
<TZ_OK> RSSI 190  Time 1312194942
<TZ_OK> RSSI 184  Time 1312194942
<TZ_OK> RSSI 198  Time 1312194942
<TZ_OK> RSSI 188  Time 1312194943
<TZ_OK> RSSI 185  Time 1312194943
<TZ_OK> RSSI 188  Time 1312194943
<TZ_OK> RSSI 189  Time 1312194943
waiting for connection
<TZ_OK> RSSI 192  Time 1312194943
<TZ_OK> RSSI 181  Time 1312194943
<TZ_OK> RSSI 199  Time 1312194943
<TZ_OK> RSSI 174  Time 1312194943
<TZ_OK> RSSI 192  Time 1312194943
<TZ_OK> RSSI 177  Time 1312194943
<TZ_OK> RSSI 186  Time 1312194943
<TZ_OK> RSSI 192  Time 1312194943
<TZ_OK> RSSI 197  Time 1312194943
<TZ_OK> RSSI 185  Time 1312194944
<TZ_OK> RSSI 197  Time 1312194944
<TZ_OK> RSSI 187  Time 1312194944
<TZ_OK> RSSI 189  Time 1312194944
<TZ_OK> RSSI 192  Time 1312194944
<TZ_OK> RSSI 186  Time 1312194944
<TZ_OK> RSSI 184  Time 1312194944
<TZ_OK> RSSI 192  Time 1312194944
<TZ_OK> RSSI 193  Time 1312194944
<TZ_OK> RSSI 200  Time 1312194944
<TZ_OK> RSSI 186  Time 1312194944
<TZ_OK> RSSI 199  Time 1312194944
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 199  Time 1312194949
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 192  Time 1312194954
<TZ_OK> RSSI 195  Time 1312194955
<TZ_OK> RSSI 189  Time 1312194955
<TZ_OK> RSSI 190  Time 1312194955
<TZ_OK> RSSI 197  Time 1312194955
<TZ_OK> RSSI 197  Time 1312194955
waiting for connection
<TZ_OK> RSSI 195  Time 1312194955
<TZ_OK> RSSI 192  Time 1312194955
<TZ_OK> RSSI 191  Time 1312194955
<TZ_OK> RSSI 193  Time 1312194955
<TZ_OK> RSSI 198  Time 1312194955
<TZ_OK> RSSI 191  Time 1312194955
<TZ_OK> RSSI 181  Time 1312194955
<TZ_OK> RSSI 188  Time 1312194955
<TZ_OK> RSSI 176  Time 1312194955
<TZ_OK> RSSI 183  Time 1312194956
<TZ_OK> RSSI 178  Time 1312194956
<TZ_OK> RSSI 191  Time 1312194956
<TZ_OK> RSSI 172  Time 1312194956
<TZ_OK> RSSI 182  Time 1312194956
<TZ_OK> RSSI 188  Time 1312194956
<TZ_OK> RSSI 185  Time 1312194956
<TZ_OK> RSSI 178  Time 1312194956
<TZ_OK> RSSI 178  Time 1312194956
<TZ_OK> RSSI 182  Time 1312194956
<TZ_OK> RSSI 175  Time 1312194956
<TZ_OK> RSSI 179  Time 1312194956
waiting for connection
<TZ_OK> RSSI 190  Time 1312194956
<TZ_OK> RSSI 183  Time 1312194956
<TZ_OK> RSSI 195  Time 1312194957
<TZ_OK> RSSI 192  Time 1312194957
<TZ_OK> RSSI 199  Time 1312194957
<TZ_OK> RSSI 198  Time 1312194957
<TZ_OK> RSSI 198  Time 1312194957
<TZ_OK> RSSI 183  Time 1312194957
<TZ_OK> RSSI 194  Time 1312194957
<TZ_OK> RSSI 191  Time 1312194957
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 191  Time 1312194962
<TZ_OK> RSSI 180  Time 1312194962
<TZ_OK> RSSI 184  Time 1312194962
<TZ_OK> RSSI 196  Time 1312194962
waiting for connection
<TZ_OK> RSSI 182  Time 1312194962
<TZ_OK> RSSI 190  Time 1312194962
<TZ_OK> RSSI 193  Time 1312194963
<TZ_OK> RSSI 193  Time 1312194963
<TZ_OK> RSSI 191  Time 1312194963
<TZ_OK> RSSI 193  Time 1312194963
<TZ_OK> RSSI 187  Time 1312194963
<TZ_OK> RSSI 188  Time 1312194963
<TZ_OK> RSSI 186  Time 1312194963
<TZ_OK> RSSI 182  Time 1312194963
<TZ_OK> RSSI 188  Time 1312194963
<TZ_OK> RSSI 188  Time 1312194963
<TZ_OK> RSSI 195  Time 1312194963
<TZ_OK> RSSI 193  Time 1312194963
<TZ_OK> RSSI 190  Time 1312194963
<TZ_OK> RSSI 192  Time 1312194963
<TZ_OK> RSSI 189  Time 1312194964
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 186  Time 1312194969
<TZ_OK> RSSI 178  Time 1312194969
<TZ_OK> RSSI 189  Time 1312194969
waiting for connection
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
waiting for connection
<TZ_OK> RSSI 186  Time 1312194974
<TZ_OK> RSSI 186  Time 1312194974
<TZ_OK> RSSI 189  Time 1312194974
<TZ_OK> RSSI 191  Time 1312194974
<TZ_OK> RSSI 186  Time 1312194974
<TZ_OK> RSSI 187  Time 1312194974
<TZ_OK> RSSI 191  Time 1312194974
<TZ_OK> RSSI 191  Time 1312194974
<TZ_OK> RSSI 181  Time 1312194974
waiting for connection
<TZ_OK> RSSI 186  Time 1312194974
<TZ_OK> RSSI 188  Time 1312194975
<TZ_OK> RSSI 191  Time 1312194975
<TZ_OK> RSSI 194  Time 1312194975
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 182  Time 1312194980
<TZ_OK> RSSI 191  Time 1312194980
<TZ_OK> RSSI 194  Time 1312194980
<TZ_OK> RSSI 190  Time 1312194980
<TZ_OK> RSSI 189  Time 1312194980
<TZ_OK> RSSI 187  Time 1312194980
<TZ_OK> RSSI 183  Time 1312194980
<TZ_OK> RSSI 193  Time 1312194980
<TZ_OK> RSSI 186  Time 1312194980
<TZ_OK> RSSI 176  Time 1312194980
<TZ_OK> RSSI 194  Time 1312194980
waiting for connection
<TZ_OK> RSSI 189  Time 1312194981
<TZ_OK> RSSI 181  Time 1312194981
<TZ_OK> RSSI 193  Time 1312194981
<TZ_OK> RSSI 188  Time 1312194981
<TZ_OK> RSSI 186  Time 1312194981
<TZ_OK> RSSI 187  Time 1312194981
<TZ_OK> RSSI 188  Time 1312194981
<TZ_OK> RSSI 179  Time 1312194981
<TZ_OK> RSSI 180  Time 1312194981
<TZ_OK> RSSI 200  Time 1312194981
<TZ_OK> RSSI 194  Time 1312194981
<TZ_OK> RSSI 200  Time 1312194981
<TZ_OK> RSSI 187  Time 1312194981
<TZ_OK> RSSI 186  Time 1312194981
<TZ_OK> RSSI 185  Time 1312194982
<TZ_OK> RSSI 195  Time 1312194982
<TZ_OK> RSSI 187  Time 1312194982
<TZ_OK> RSSI 178  Time 1312194982
<TZ_OK> RSSI 197  Time 1312194982
<TZ_OK> RSSI 199  Time 1312194982
<TZ_OK> RSSI 189  Time 1312194982
waiting for connection
<TZ_OK> RSSI 197  Time 1312194982
<TZ_OK> RSSI 196  Time 1312194982
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
<TZ_OK> RSSI 195  Time 1312194982
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 185  Time 1312194987
<TZ_OK> RSSI 173  Time 1312194987
<TZ_OK> RSSI 195  Time 1312194987
<TZ_OK> RSSI 194  Time 1312194987
<TZ_OK> RSSI 181  Time 1312194988
<TZ_OK> RSSI 198  Time 1312194988
<TZ_OK> RSSI 192  Time 1312194988
<TZ_OK> RSSI 195  Time 1312194988
<TZ_OK> RSSI 199  Time 1312194988
<TZ_OK> RSSI 183  Time 1312194988
<TZ_OK> RSSI 200  Time 1312194988
<TZ_OK> RSSI 182  Time 1312194988
<TZ_OK> RSSI 193  Time 1312194988
waiting for connection
<TZ_OK> RSSI 192  Time 1312194988
<TZ_OK> RSSI 192  Time 1312194988
<TZ_OK> RSSI 191  Time 1312194988
<TZ_OK> RSSI 192  Time 1312194988
<TZ_OK> RSSI 177  Time 1312194988
<TZ_OK> RSSI 193  Time 1312194989
<TZ_OK> RSSI 191  Time 1312194989
<TZ_OK> RSSI 183  Time 1312194989
<TZ_OK> RSSI 176  Time 1312194989
<TZ_OK> RSSI 179  Time 1312194989
<TZ_OK> RSSI 193  Time 1312194989
<TZ_OK> RSSI 193  Time 1312194989
<TZ_OK> RSSI 175  Time 1312194989
<TZ_OK> RSSI 193  Time 1312194989
<TZ_OK> RSSI 181  Time 1312194989
<TZ_OK> RSSI 187  Time 1312194989
<TZ_OK> RSSI 189  Time 1312194989
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 194  Time 1312194994
<TZ_OK> RSSI 187  Time 1312194994
<TZ_OK> RSSI 189  Time 1312194994
<TZ_OK> RSSI 181  Time 1312194995
<TZ_OK> RSSI 191  Time 1312194995
<TZ_OK> RSSI 192  Time 1312194995
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
<TZ_OK> RSSI 190  Time 1312194995
<TZ_OK> RSSI 189  Time 1312194995
<TZ_OK> RSSI 187  Time 1312194995
<TZ_OK> RSSI 179  Time 1312194995
<TZ_OK> RSSI 190  Time 1312194995
<TZ_OK> RSSI 176  Time 1312194995
<TZ_OK> RSSI 180  Time 1312194995
<TZ_OK> RSSI 200  Time 1312194995
<TZ_OK> RSSI 183  Time 1312194995
<TZ_OK> RSSI 193  Time 1312194995
<TZ_OK> RSSI 188  Time 1312194996
<TZ_OK> RSSI 201  Time 1312194996
<TZ_OK> RSSI 176  Time 1312194996
<TZ_OK> RSSI 189  Time 1312194996
<TZ_OK> RSSI 180  Time 1312194996
<TZ_OK> RSSI 195  Time 1312194996
<TZ_OK> RSSI 189  Time 1312194996
<TZ_OK> RSSI 192  Time 1312194996
<TZ_OK> RSSI 194  Time 1312194996
<TZ_OK> RSSI 185  Time 1312194996
<TZ_OK> RSSI 194  Time 1312194996
waiting for connection
<TZ_OK> RSSI 192  Time 1312194996
<TZ_OK> RSSI 192  Time 1312194996
<TZ_OK> RSSI 192  Time 1312194996
<TZ_OK> RSSI 192  Time 1312194996
<TZ_OK> RSSI 190  Time 1312194997
<TZ_OK> RSSI 190  Time 1312194997
<TZ_OK> RSSI 194  Time 1312194997
<TZ_OK> RSSI 198  Time 1312194997
<TZ_OK> RSSI 192  Time 1312194997
<TZ_OK> RSSI 192  Time 1312194997
<TZ_OK> RSSI 193  Time 1312194997
<TZ_OK> RSSI 200  Time 1312194997
<TZ_OK> RSSI 198  Time 1312194997
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 192  Time 1312195002
waiting for connection
<TZ_OK> RSSI 190  Time 1312195002
<TZ_OK> RSSI 198  Time 1312195002
<TZ_OK> RSSI 194  Time 1312195002
<TZ_OK> RSSI 185  Time 1312195003
<TZ_OK> RSSI 181  Time 1312195003
<TZ_OK> RSSI 175  Time 1312195003
<TZ_OK> RSSI 178  Time 1312195003
<TZ_OK> RSSI 193  Time 1312195003
<TZ_OK> RSSI 174  Time 1312195003
<TZ_OK> RSSI 198  Time 1312195003
<TZ_OK> RSSI 194  Time 1312195003
<TZ_OK> RSSI 182  Time 1312195003
<TZ_OK> RSSI 186  Time 1312195003
<TZ_OK> RSSI 193  Time 1312195003
<TZ_OK> RSSI 181  Time 1312195003
<TZ_OK> RSSI 186  Time 1312195003
<TZ_OK> RSSI 179  Time 1312195003
<TZ_OK> RSSI 186  Time 1312195003
waiting for connection
waiting for connection
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
<TZ_OK> RSSI 182  Time 1312195009
<TZ_OK> RSSI 197  Time 1312195009
<TZ_OK> RSSI 182  Time 1312195009
<TZ_OK> RSSI 188  Time 1312195009
<TZ_OK> RSSI 195  Time 1312195009
<TZ_OK> RSSI 188  Time 1312195009
<TZ_OK> RSSI 195  Time 1312195009
<TZ_OK> RSSI 193  Time 1312195009
<TZ_OK> RSSI 185  Time 1312195009
<TZ_OK> RSSI 184  Time 1312195009
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 183  Time 1312195014
<TZ_OK> RSSI 194  Time 1312195014
<TZ_OK> RSSI 186  Time 1312195014
<TZ_OK> RSSI 177  Time 1312195015
<TZ_OK> RSSI 185  Time 1312195015
<TZ_OK> RSSI 191  Time 1312195015
<TZ_OK> RSSI 186  Time 1312195015
<TZ_OK> RSSI 195  Time 1312195015
<TZ_OK> RSSI 194  Time 1312195015
<TZ_OK> RSSI 198  Time 1312195015
<TZ_OK> RSSI 197  Time 1312195015
<TZ_OK> RSSI 198  Time 1312195015
<TZ_OK> RSSI 194  Time 1312195015
<TZ_OK> RSSI 195  Time 1312195015
<TZ_OK> RSSI 188  Time 1312195015
<TZ_OK> RSSI 194  Time 1312195015
waiting for connection
<TZ_OK> RSSI 192  Time 1312195015
<TZ_OK> RSSI 194  Time 1312195016
<TZ_OK> RSSI 183  Time 1312195016
<TZ_OK> RSSI 193  Time 1312195016
<TZ_OK> RSSI 188  Time 1312195016
<TZ_OK> RSSI 198  Time 1312195016
<TZ_OK> RSSI 185  Time 1312195016
<TZ_OK> RSSI 190  Time 1312195016
<TZ_OK> RSSI 184  Time 1312195016
<TZ_OK> RSSI 185  Time 1312195016
<TZ_OK> RSSI 184  Time 1312195016
<TZ_OK> RSSI 192  Time 1312195016
<TZ_OK> RSSI 181  Time 1312195016
<TZ_OK> RSSI 187  Time 1312195016
<TZ_OK> RSSI 193  Time 1312195016
<TZ_OK> RSSI 185  Time 1312195016
<TZ_OK> RSSI 193  Time 1312195017
<TZ_OK> RSSI 189  Time 1312195017
<TZ_OK> RSSI 189  Time 1312195017
<TZ_OK> RSSI 189  Time 1312195017
<TZ_OK> RSSI 193  Time 1312195017
waiting for connection
<TZ_OK> RSSI 193  Time 1312195017
<TZ_OK> RSSI 188  Time 1312195017
<TZ_OK> RSSI 187  Time 1312195017
<TZ_OK> RSSI 193  Time 1312195017
<TZ_OK> RSSI 188  Time 1312195017
<TZ_OK> RSSI 194  Time 1312195017
<TZ_OK> RSSI 187  Time 1312195017
<TZ_OK> RSSI 189  Time 1312195017
<TZ_OK> RSSI 196  Time 1312195017
<TZ_OK> RSSI 188  Time 1312195018
<TZ_OK> RSSI 179  Time 1312195018
<TZ_OK> RSSI 197  Time 1312195018
<TZ_OK> RSSI 191  Time 1312195018
<TZ_OK> RSSI 188  Time 1312195018
<TZ_OK> RSSI 189  Time 1312195018
<TZ_OK> RSSI 180  Time 1312195018
<TZ_OK> RSSI 187  Time 1312195018
<TZ_OK> RSSI 189  Time 1312195018
<TZ_OK> RSSI 197  Time 1312195018
<TZ_OK> RSSI 187  Time 1312195018
<TZ_OK> RSSI 194  Time 1312195018
waiting for connection
<TZ_OK> RSSI 189  Time 1312195018
<TZ_OK> RSSI 189  Time 1312195018
<TZ_OK> RSSI 189  Time 1312195019
<TZ_OK> RSSI 189  Time 1312195019
<TZ_OK> RSSI 191  Time 1312195019
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
waiting for connection
waiting for connection
<TZ_OK> RSSI 189  Time 1312195024
<TZ_OK> RSSI 194  Time 1312195024
<TZ_OK> RSSI 191  Time 1312195024
<TZ_OK> RSSI 189  Time 1312195024
<TZ_OK> RSSI 192  Time 1312195024
<TZ_OK> RSSI 177  Time 1312195024
<TZ_OK> RSSI 194  Time 1312195024
<TZ_OK> RSSI 177  Time 1312195024
<TZ_OK> RSSI 177  Time 1312195024
<TZ_OK> RSSI 198  Time 1312195024
<TZ_OK> RSSI 188  Time 1312195024
<TZ_OK> RSSI 193  Time 1312195025
<TZ_OK> RSSI 182  Time 1312195025
<TZ_OK> RSSI 179  Time 1312195025
waiting for connection
<TZ_OK> RSSI 181  Time 1312195025
<TZ_OK> RSSI 185  Time 1312195025
<TZ_OK> RSSI 179  Time 1312195025
<TZ_OK> RSSI 201  Time 1312195025
<TZ_OK> RSSI 198  Time 1312195025
<TZ_OK> RSSI 198  Time 1312195025
<TZ_OK> RSSI 199  Time 1312195025
<TZ_OK> RSSI 178  Time 1312195025
<TZ_OK> RSSI 193  Time 1312195025
<TZ_OK> RSSI 192  Time 1312195025
<TZ_OK> RSSI 182  Time 1312195025
<TZ_OK> RSSI 190  Time 1312195026
<TZ_OK> RSSI 190  Time 1312195026
<TZ_OK> RSSI 183  Time 1312195026
<TZ_OK> RSSI 192  Time 1312195026
<TZ_OK> RSSI 188  Time 1312195026
<TZ_OK> RSSI 192  Time 1312195026
<TZ_OK> RSSI 181  Time 1312195026
<TZ_OK> RSSI 184  Time 1312195026
<TZ_OK> RSSI 171  Time 1312195026
<TZ_OK> RSSI 187  Time 1312195026
<TZ_OK> RSSI 190  Time 1312195026
waiting for connection
<TZ_OK> RSSI 182  Time 1312195026
<TZ_OK> RSSI 191  Time 1312195026
<TZ_OK> RSSI 177  Time 1312195026
<TZ_OK> RSSI 181  Time 1312195027
<TZ_OK> RSSI 180  Time 1312195027
<TZ_OK> RSSI 192  Time 1312195027
<TZ_OK> RSSI 198  Time 1312195027
<TZ_OK> RSSI 195  Time 1312195027
<TZ_OK> RSSI 197  Time 1312195027
<TZ_OK> RSSI 193  Time 1312195027
<TZ_OK> RSSI 195  Time 1312195027
<TZ_OK> RSSI 197  Time 1312195027
<TZ_OK> RSSI 193  Time 1312195027
<TZ_OK> RSSI 193  Time 1312195027
<TZ_OK> RSSI 192  Time 1312195027
<TZ_OK> RSSI 202  Time 1312195027
<TZ_OK> RSSI 191  Time 1312195027
<TZ_OK> RSSI 195  Time 1312195028
<TZ_OK> RSSI 195  Time 1312195028
<TZ_OK> RSSI 199  Time 1312195028
waiting for connection
<TZ_OK> RSSI 177  Time 1312195028
<TZ_OK> RSSI 186  Time 1312195028
<TZ_OK> RSSI 186  Time 1312195028
<TZ_OK> RSSI 197  Time 1312195028
<TZ_OK> RSSI 193  Time 1312195028
<TZ_OK> RSSI 178  Time 1312195028
<TZ_OK> RSSI 188  Time 1312195028
<TZ_OK> RSSI 184  Time 1312195028
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 191  Time 1312195033
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
<TZ_OK> RSSI 193  Time 1312195033
<TZ_OK> RSSI 185  Time 1312195033
<TZ_OK> RSSI 180  Time 1312195034
<TZ_OK> RSSI 194  Time 1312195034
<TZ_OK> RSSI 186  Time 1312195034
<TZ_OK> RSSI 193  Time 1312195034
<TZ_OK> RSSI 189  Time 1312195034
<TZ_OK> RSSI 175  Time 1312195034
<TZ_OK> RSSI 193  Time 1312195034
<TZ_OK> RSSI 188  Time 1312195034
<TZ_OK>waiting for connection
waiting for connection
waiting for connection
waiting for connection
waiting for connection
waiting for connection
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
Inquiry
waiting for connection
Starting inquiry with RSSI...
thread end
 RSSI 192  Time 1312195046
<TZ_OK>waiting for connection
 RSSI 183  Time 1312195046
<TZ_OK> RSSI 193  Time 1312195046
<TZ_OK> RSSI 192  Time 1312195046
<TZ_OK> RSSI 192  Time 1312195047
<TZ_OK> RSSI 190  Time 1312195047
<TZ_OK> RSSI 188  Time 1312195047
<TZ_OK> RSSI 198  Time 1312195047
<TZ_OK> RSSI 197  Time 1312195047
<TZ_OK> RSSI 198  Time 1312195047
<TZ_OK> RSSI 178  Time 1312195048
<TZ_OK>waiting for connection
 RSSI 192  Time 1312195048
<TZ_OK> RSSI 185  Time 1312195048
<TZ_OK> RSSI 177  Time 1312195048
<TZ_OK> RSSI 184  Time 1312195048
<TZ_OK> RSSI 190  Time 1312195048
<TZ_OK> RSSI 183  Time 1312195048
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 183  Time 1312195053
<TZ_OK> RSSI 184  Time 1312195054
<TZ_OK> RSSI 181  Time 1312195054
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 193  Time 1312195059
<TZ_OK> RSSI 199  Time 1312195059
<TZ_OK> RSSI 197  Time 1312195059
<TZ_OK> RSSI 202  Time 1312195059
<TZ_OK> RSSI 188  Time 1312195059
<TZ_OK> RSSI 181  Time 1312195059
<TZ_OK> RSSI 185  Time 1312195059
<TZ_OK> RSSI 172  Time 1312195059
<TZ_OK> RSSI 185  Time 1312195059
<TZ_OK> RSSI 177  Time 1312195059
<TZ_OK> RSSI 194  Time 1312195059
<TZ_OK> RSSI 175  Time 1312195059
<TZ_OK> RSSI 188  Time 1312195060
<TZ_OK> RSSI 186  Time 1312195060
<TZ_OK> RSSI 183  Time 1312195060
<TZ_OK> RSSI 197  Time 1312195060
<TZ_OK> RSSI 195  Time 1312195060
waiting for connection
<TZ_OK> RSSI 194  Time 1312195060
<TZ_OK> RSSI 182  Time 1312195060
<TZ_OK> RSSI 185  Time 1312195060
<TZ_OK> RSSI 195  Time 1312195060
<TZ_OK> RSSI 192  Time 1312195060
<TZ_OK> RSSI 192  Time 1312195060
<TZ_OK> RSSI 179  Time 1312195060
<TZ_OK> RSSI 189  Time 1312195060
<TZ_OK> RSSI 193  Time 1312195060
<TZ_OK> RSSI 183  Time 1312195060
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 197  Time 1312195066
<TZ_OK> RSSI 177  Time 1312195066
<TZ_OK> RSSI 194  Time 1312195066
<TZ_OK> RSSI 186  Time 1312195066
waiting for connection
<TZ_OK> RSSI 198  Time 1312195066
<TZ_OK> RSSI 187  Time 1312195066
<TZ_OK> RSSI 187  Time 1312195066
<TZ_OK> RSSI 188  Time 1312195066
<TZ_OK> RSSI 193  Time 1312195066
<TZ_OK> RSSI 187  Time 1312195066
<TZ_OK> RSSI 198  Time 1312195066
<TZ_OK> RSSI 197  Time 1312195066
<TZ_OK> RSSI 179  Time 1312195066
<TZ_OK> RSSI 189  Time 1312195066
<TZ_OK> RSSI 191  Time 1312195067
<TZ_OK> RSSI 191  Time 1312195067
<TZ_OK> RSSI 192  Time 1312195067
<TZ_OK> RSSI 183  Time 1312195067
<TZ_OK> RSSI 197  Time 1312195067
<TZ_OK> RSSI 198  Time 1312195067
<TZ_OK> RSSI 195  Time 1312195067
<TZ_OK> RSSI 187  Time 1312195067
<TZ_OK> RSSI 189  Time 1312195067
<TZ_OK> RSSI 176  Time 1312195067
<TZ_OK> RSSI 200  Time 1312195067
waiting for connection
<TZ_OK> RSSI 183  Time 1312195067
<TZ_OK> RSSI 183  Time 1312195067
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 192  Time 1312195072
<TZ_OK> RSSI 190  Time 1312195073
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 198  Time 1312195078
<TZ_OK> RSSI 178  Time 1312195078
<TZ_OK> RSSI 192  Time 1312195078
waiting for connection
<TZ_OK> RSSI 184  Time 1312195078
<TZ_OK> RSSI 192  Time 1312195078
<TZ_OK> RSSI 188  Time 1312195078
<TZ_OK> RSSI 177  Time 1312195078
<TZ_OK> RSSI 183  Time 1312195078
<TZ_OK> RSSI 189  Time 1312195078
<TZ_OK> RSSI 186  Time 1312195078
<TZ_OK> RSSI 199  Time 1312195078
<TZ_OK> RSSI 188  Time 1312195078
<TZ_OK> RSSI 199  Time 1312195078
<TZ_OK> RSSI 182  Time 1312195079
<TZ_OK> RSSI 187  Time 1312195079
<TZ_OK> RSSI 189  Time 1312195079
<TZ_OK> RSSI 199  Time 1312195079
<TZ_OK> RSSI 192  Time 1312195079
<TZ_OK> RSSI 188  Time 1312195079
<TZ_OK> RSSI 177  Time 1312195079
<TZ_OK> RSSI 199  Time 1312195079
<TZ_OK> RSSI 181  Time 1312195079
<TZ_OK> RSSI 187  Time 1312195079
<TZ_OK> RSSI 199  Time 1312195079
waiting for connection
<TZ_OK> RSSI 187  Time 1312195079
<TZ_OK> RSSI 190  Time 1312195079
<TZ_OK> RSSI 189  Time 1312195080
<TZ_OK> RSSI 186  Time 1312195080
<TZ_OK> RSSI 193  Time 1312195080
<TZ_OK> RSSI 194  Time 1312195080
<TZ_OK> RSSI 182  Time 1312195080
<TZ_OK> RSSI 190  Time 1312195080
<TZ_OK> RSSI 187  Time 1312195080
<TZ_OK> RSSI 194  Time 1312195080
<TZ_OK> RSSI 192  Time 1312195080
<TZ_OK> RSSI 194  Time 1312195080
<TZ_OK> RSSI 188  Time 1312195080
<TZ_OK> RSSI 188  Time 1312195080
<TZ_OK> RSSI 186  Time 1312195080
<TZ_OK> RSSI 200  Time 1312195080
<TZ_OK> RSSI 191  Time 1312195080
<TZ_OK> RSSI 198  Time 1312195081
<TZ_OK> RSSI 185  Time 1312195081
<TZ_OK> RSSI 187  Time 1312195081
<TZ_OK> RSSI 199  Time 1312195081
<TZ_OK> RSSI 189  Time 1312195081
waiting for connection
<TZ_OK> RSSI 194  Time 1312195081
<TZ_OK> RSSI 181  Time 1312195081
<TZ_OK> RSSI 191  Time 1312195081
<TZ_OK> RSSI 185  Time 1312195081
<TZ_OK> RSSI 196  Time 1312195081
<TZ_OK> RSSI 185  Time 1312195081
<TZ_OK> RSSI 183  Time 1312195081
<TZ_OK> RSSI 185  Time 1312195081
<TZ_OK> RSSI 195  Time 1312195081
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 200  Time 1312195087
<TZ_OK> RSSI 183  Time 1312195087
<TZ_OK> RSSI 187  Time 1312195087
<TZ_OK> RSSI 179  Time 1312195087
<TZ_OK> RSSI 198  Time 1312195087
waiting for connection
<TZ_OK> RSSI 188  Time 1312195087
<TZ_OK> RSSI 191  Time 1312195087
<TZ_OK> RSSI 196  Time 1312195087
<TZ_OK> RSSI 193  Time 1312195087
<TZ_OK> RSSI 189  Time 1312195087
<TZ_OK> RSSI 189  Time 1312195087
<TZ_OK> RSSI 197  Time 1312195087
<TZ_OK> RSSI 188  Time 1312195087
<TZ_OK> RSSI 196  Time 1312195087
<TZ_OK> RSSI 183  Time 1312195088
<TZ_OK> RSSI 185  Time 1312195088
<TZ_OK> RSSI 194  Time 1312195088
<TZ_OK> RSSI 182  Time 1312195088
<TZ_OK> RSSI 186  Time 1312195088
<TZ_OK> RSSI 196  Time 1312195088
<TZ_OK> RSSI 181  Time 1312195088
<TZ_OK> RSSI 179  Time 1312195088
<TZ_OK> RSSI 171  Time 1312195088
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 187  Time 1312195093
<TZ_OK> RSSI 188  Time 1312195093
<TZ_OK> RSSI 185  Time 1312195093
<TZ_OK> RSSI 196  Time 1312195093
<TZ_OK> RSSI 175  Time 1312195093
<TZ_OK> RSSI 198  Time 1312195094
<TZ_OK> RSSI 188  Time 1312195094
<TZ_OK> RSSI 190  Time 1312195094
<TZ_OK> RSSI 191  Time 1312195094
<TZ_OK> RSSI 182  Time 1312195094
<TZ_OK> RSSI 184  Time 1312195094
<TZ_OK> RSSI 189  Time 1312195094
<TZ_OK> RSSI 181  Time 1312195094
<TZ_OK> RSSI 186  Time 1312195094
<TZ_OK> RSSI 181  Time 1312195094
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 177  Time 1312195099
<TZ_OK> RSSI 188  Time 1312195099
<TZ_OK> RSSI 188  Time 1312195099
<TZ_OK> RSSI 191  Time 1312195099
<TZ_OK> RSSI 191  Time 1312195099
<TZ_OK> RSSI 180  Time 1312195100
<TZ_OK> RSSI 188  Time 1312195100
<TZ_OK> RSSI 188  Time 1312195100
<TZ_OK> RSSI 183  Time 1312195100
<TZ_OK> RSSI 185  Time 1312195100
<TZ_OK> RSSI 191  Time 1312195100
<TZ_OK> RSSI 189  Time 1312195100
<TZ_OK> RSSI 181  Time 1312195100
<TZ_OK> RSSI 194  Time 1312195100
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 196  Time 1312195105
<TZ_OK> RSSI 194  Time 1312195105
<TZ_OK> RSSI 191  Time 1312195105
<TZ_OK> RSSI 187  Time 1312195105
<TZ_OK> RSSI 189  Time 1312195105
<TZ_OK> RSSI 181  Time 1312195106
<TZ_OK> RSSI 197  Time 1312195106
<TZ_OK> RSSI 191  Time 1312195106
<TZ_OK> RSSI 192  Time 1312195106
<TZ_OK> RSSI 188  Time 1312195106
<TZ_OK> RSSI 177  Time 1312195106
<TZ_OK> RSSI 191  Time 1312195106
<TZ_OK> RSSI 180  Time 1312195106
<TZ_OK> RSSI 177  Time 1312195106
<TZ_OK> RSSI 187  Time 1312195106
<TZ_OK> RSSI 191  Time 1312195106
<TZ_OK> RSSI 187  Time 1312195106
waiting for connection
<TZ_OK> RSSI 173  Time 1312195106
<TZ_OK> RSSI 185  Time 1312195106
<TZ_OK> RSSI 180  Time 1312195107
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 193  Time 1312195112
<TZ_OK> RSSI 183  Time 1312195112
<TZ_OK> RSSI 188  Time 1312195112
<TZ_OK> RSSI 191  Time 1312195112
<TZ_OK> RSSI 185  Time 1312195112
<TZ_OK> RSSI 198  Time 1312195112
<TZ_OK> RSSI 196  Time 1312195112
<TZ_OK> RSSI 188  Time 1312195112
<TZ_OK> RSSI 190  Time 1312195112
<TZ_OK> RSSI 178  Time 1312195112
<TZ_OK> RSSI 186  Time 1312195112
waiting for connection
<TZ_OK> RSSI 187  Time 1312195112
<TZ_OK> RSSI 195  Time 1312195112
<TZ_OK> RSSI 187  Time 1312195113
<TZ_OK> RSSI 179  Time 1312195113
<TZ_OK> RSSI 195  Time 1312195113
<TZ_OK> RSSI 182  Time 1312195113
<TZ_OK> RSSI 189  Time 1312195113
<TZ_OK> RSSI 176  Time 1312195113
<TZ_OK> RSSI 192  Time 1312195113
<TZ_OK> RSSI 176  Time 1312195113
<TZ_OK> RSSI 194  Time 1312195113
<TZ_OK> RSSI 184  Time 1312195113
<TZ_OK> RSSI 178  Time 1312195113
<TZ_OK> RSSI 190  Time 1312195113
<TZ_OK> RSSI 186  Time 1312195113
<TZ_OK> RSSI 194  Time 1312195113
<TZ_OK> RSSI 189  Time 1312195114
<TZ_OK> RSSI 179  Time 1312195114
<TZ_OK> RSSI 179  Time 1312195114
<TZ_OK> RSSI 198  Time 1312195114
<TZ_OK> RSSI 187  Time 1312195114
<TZ_OK> RSSI 181  Time 1312195114
waiting for connection
<TZ_OK> RSSI 174  Time 1312195114
<TZ_OK> RSSI 192  Time 1312195114
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 187  Time 1312195119
<TZ_OK> RSSI 193  Time 1312195119
<TZ_OK> RSSI 184  Time 1312195119
<TZ_OK> RSSI 187  Time 1312195119
<TZ_OK> RSSI 180  Time 1312195119
<TZ_OK> RSSI 191  Time 1312195119
<TZ_OK> RSSI 185  Time 1312195119
<TZ_OK> RSSI 187  Time 1312195120
<TZ_OK> RSSI 194  Time 1312195120
<TZ_OK> RSSI 193  Time 1312195120
<TZ_OK> RSSI 185  Time 1312195120
<TZ_OK> RSSI 180  Time 1312195120
waiting for connection
<TZ_OK> RSSI 187  Time 1312195120
<TZ_OK> RSSI 185  Time 1312195120
<TZ_OK> RSSI 183  Time 1312195120
<TZ_OK> RSSI 192  Time 1312195120
<TZ_OK> RSSI 193  Time 1312195120
<TZ_OK> RSSI 195  Time 1312195120
<TZ_OK> RSSI 193  Time 1312195120
<TZ_OK> RSSI 181  Time 1312195120
<TZ_OK> RSSI 191  Time 1312195120
<TZ_OK> RSSI 199  Time 1312195121
<TZ_OK> RSSI 190  Time 1312195121
<TZ_OK> RSSI 171  Time 1312195121
<TZ_OK> RSSI 191  Time 1312195121
<TZ_OK> RSSI 201  Time 1312195121
<TZ_OK> RSSI 171  Time 1312195121
<TZ_OK> RSSI 178  Time 1312195121
<TZ_OK> RSSI 188  Time 1312195121
<TZ_OK> RSSI 194  Time 1312195121
<TZ_OK> RSSI 180  Time 1312195121
waiting for connection
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
waiting for connection
waiting for connection
<TZ_OK> RSSI 186  Time 1312195126
<TZ_OK> RSSI 179  Time 1312195126
<TZ_OK> RSSI 180  Time 1312195126
<TZ_OK> RSSI 196  Time 1312195126
<TZ_OK> RSSI 193  Time 1312195127
<TZ_OK> RSSI 187  Time 1312195127
<TZ_OK> RSSI 189  Time 1312195127
<TZ_OK> RSSI 181  Time 1312195127
<TZ_OK> RSSI 189  Time 1312195127
<TZ_OK> RSSI 183  Time 1312195127
<TZ_OK> RSSI 183  Time 1312195127
waiting for connection
waiting for connection
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
thread end
waiting for connection
<TZ_OK> RSSI 190  Time 1312195132
<TZ_OK> RSSI 195  Time 1312195132
waiting for connection
<TZ_OK> RSSI 193  Time 1312195132
<TZ_OK> RSSI 184  Time 1312195132
<TZ_OK> RSSI 191  Time 1312195132
<TZ_OK> RSSI 182  Time 1312195132
<TZ_OK> RSSI 188  Time 1312195132
<TZ_OK> RSSI 189  Time 1312195133
<TZ_OK> RSSI 178  Time 1312195133
<TZ_OK> RSSI 183  Time 1312195133
waiting for connection
waiting for connection
waiting for connection
accepted connection from 00:15:83:15:A3:10
received [{"sala":"Sala tziranda","conteudos":[{"i":"qualquercoisa","t":"qualquercoisa2","d":"a"}]}]
thread created and detached
waiting for connection
thread end
<TZ_OK> RSSI 184  Time 1312195138
<TZ_OK> RSSI 188  Time 1312195138
<TZ_OK> RSSI 188  Time 1312195138
<TZ_OK> RSSI 184  Time 1312195138
<TZ_OK> RSSI 193  Time 1312195138
waiting for connection
waiting for connection
waiting for connection
waiting for connection
<TZ_OK> RSSI 171  Time 1312195143
<TZ_OK> RSSI 191  Time 1312195143
waiting for connection
waiting for connection
 RSSI 179  Time 1312195146
<TZ_OK> RSSI 188  Time 1312195146
<TZ_OK> RSSI 189  Time 1312195146
<TZ_OK> RSSI 192  Time 1312195146
<TZ_OK> RSSI 199  Time 1312195146
<TZ_OK> RSSI 181  Time 1312195147
<TZ_OK> RSSI 191  Time 1312195147
waiting for connection
 RSSI 183  Time 1312195148
<TZ_OK> RSSI 183  Time 1312195148
<TZ_OK> RSSI 183  Time 1312195148
<TZ_OK> RSSI 178  Time 1312195148
<TZ_OK> RSSI 183  Time 1312195148
<TZ_OK> RSSI 179  Time 1312195148
<TZ_OK> RSSI 191  Time 1312195148
<TZ_OK> RSSI 190  Time 1312195148
<TZ_OK> RSSI 184  Time 1312195148
<TZ_OK> RSSI 181  Time 1312195148
<TZ_OK> RSSI 190  Time 1312195149
<TZ_OK> RSSI 175  Time 1312195149
<TZ_OK> RSSI 185  Time 1312195149
<TZ_OK> RSSI 194  Time 1312195149
waiting for connection
 RSSI 189  Time 1312195150
<TZ_OK> RSSI 192  Time 1312195150
<TZ_OK> RSSI 192  Time 1312195150
<TZ_OK> RSSI 181  Time 1312195150
<TZ_OK> RSSI 177  Time 1312195150
<TZ_OK> RSSI 184  Time 1312195150
<TZ_OK> RSSI 187  Time 1312195150
<TZ_OK> RSSI 198  Time 1312195150
<TZ_OK> RSSI 184  Time 1312195150
<TZ_OK> RSSI 197  Time 1312195150
<TZ_OK> RSSI 181  Time 1312195150
<TZ_OK> RSSI 193  Time 1312195150
<TZ_OK> RSSI 192  Time 1312195150
<TZ_OK> RSSI 183  Time 1312195150
waiting for connection
<TZ_OK> RSSI 199  Time 1312195150
<TZ_OK> RSSI 197  Time 1312195151
<TZ_OK> RSSI 195  Time 1312195151
<TZ_OK> RSSI 187  Time 1312195151
<TZ_OK> RSSI 178  Time 1312195151
<TZ_OK> RSSI 191  Time 1312195151
<TZ_OK> RSSI 180  Time 1312195151
<TZ_OK> RSSI 183  Time 1312195151
 RSSI 177  Time 1312195151
<TZ_OK> RSSI 183  Time 1312195151
<TZ_OK> RSSI 182  Time 1312195151
<TZ_OK> RSSI 192  Time 1312195151
<TZ_OK> RSSI 177  Time 1312195151
<TZ_OK> RSSI 182  Time 1312195151
<TZ_OK> RSSI 177  Time 1312195151
<TZ_OK> RSSI 188  Time 1312195151
<TZ_OK> RSSI 172  Time 1312195152
<TZ_OK> RSSI 185  Time 1312195152
<TZ_OK> RSSI 171  Time 1312195152
<TZ_OK> RSSI 192  Time 1312195152
<TZ_OK> RSSI 198  Time 1312195152
waiting for connection
<TZ_OK> RSSI 177  Time 1312195152
<TZ_OK> RSSI 192  Time 1312195152
<TZ_OK> RSSI 194  Time 1312195152
<TZ_OK> RSSI 193  Time 1312195152
<TZ_OK> RSSI 187  Time 1312195152
<TZ_OK> RSSI 179  Time 1312195152
<TZ_OK> RSSI 187  Time 1312195152
 RSSI 191  Time 1312195152
<TZ_OK> RSSI 197  Time 1312195152
<TZ_OK> RSSI 193  Time 1312195153
<TZ_OK> RSSI 190  Time 1312195153
<TZ_OK> RSSI 181  Time 1312195153
<TZ_OK> RSSI 176  Time 1312195153
<TZ_OK> RSSI 199  Time 1312195153
<TZ_OK> RSSI 198  Time 1312195153
<TZ_OK> RSSI 198  Time 1312195153
<TZ_OK> RSSI 198  Time 1312195153
<TZ_OK> RSSI 179  Time 1312195153
<TZ_OK> RSSI 192  Time 1312195153
<TZ_OK> RSSI 195  Time 1312195153
<TZ_OK> RSSI 183  Time 1312195153
<TZ_OK> RSSI 193  Time 1312195153
waiting for connection
<TZ_OK> RSSI 195  Time 1312195153
<TZ_OK> RSSI 188  Time 1312195154
<TZ_OK> RSSI 189  Time 1312195154
<TZ_OK> RSSI 189  Time 1312195154
<TZ_OK> RSSI 197  Time 1312195154
 RSSI 188  Time 1312195154
<TZ_OK> RSSI 185  Time 1312195154
<TZ_OK> RSSI 186  Time 1312195154
waiting for connection
 RSSI 188  Time 1312195155
<TZ_OK> RSSI 186  Time 1312195155
<TZ_OK> RSSI 173  Time 1312195156
waiting for connection
 RSSI 191  Time 1312195157
<TZ_OK> RSSI 191  Time 1312195157
<TZ_OK> RSSI 190  Time 1312195157
<TZ_OK> RSSI 186  Time 1312195157
<TZ_OK> RSSI 184  Time 1312195157
<TZ_OK> RSSI 181  Time 1312195157
<TZ_OK> RSSI 194  Time 1312195157
<TZ_OK> RSSI 187  Time 1312195158
<TZ_OK> RSSI 180  Time 1312195158
<TZ_OK> RSSI 195  Time 1312195158
<TZ_OK> RSSI 191  Time 1312195158
<TZ_OK> RSSI 186  Time 1312195158
<TZ_OK> RSSI 186  Time 1312195158
waiting for connection
<TZ_OK> RSSI 187  Time 1312195158
<TZ_OK> RSSI 189  Time 1312195158
<TZ_OK> RSSI 193  Time 1312195158
<TZ_OK> RSSI 187  Time 1312195158
<TZ_OK> RSSI 171  Time 1312195158
<TZ_OK> RSSI 186  Time 1312195158
<TZ_OK> RSSI 197  Time 1312195158
<TZ_OK> RSSI 189  Time 1312195158
<TZ_OK> RSSI 192  Time 1312195158
 RSSI 197  Time 1312195159
waiting for connection
waiting for connection
 RSSI 189  Time 1312195161
<TZ_OK> RSSI 189  Time 1312195161
<TZ_OK> RSSI 190  Time 1312195161
<TZ_OK> RSSI 182  Time 1312195161
<TZ_OK> RSSI 182  Time 1312195161
<TZ_OK> RSSI 186  Time 1312195161
<TZ_OK> RSSI 188  Time 1312195161
<TZ_OK> RSSI 181  Time 1312195162
<TZ_OK> RSSI 194  Time 1312195162
<TZ_OK> RSSI 177  Time 1312195162
<TZ_OK> RSSI 189  Time 1312195162
<TZ_OK> RSSI 188  Time 1312195162
<TZ_OK> RSSI 193  Time 1312195162
<TZ_OK> RSSI 187  Time 1312195162
<TZ_OK> RSSI 193  Time 1312195162
<TZ_OK> RSSI 170  Time 1312195162
<TZ_OK> RSSI 183  Time 1312195162
<TZ_OK> RSSI 188  Time 1312195162
<TZ_OK> RSSI 199  Time 1312195162
<TZ_OK> RSSI 186  Time 1312195162
 RSSI 177  Time 1312195162
waiting for connection
<TZ_OK> RSSI 191  Time 1312195163
<TZ_OK> RSSI 195  Time 1312195163
<TZ_OK> RSSI 191  Time 1312195163
<TZ_OK> RSSI 199  Time 1312195163
<TZ_OK> RSSI 187  Time 1312195163
<TZ_OK> RSSI 191  Time 1312195163
<TZ_OK> RSSI 178  Time 1312195163
<TZ_OK> RSSI 187  Time 1312195163
<TZ_OK> RSSI 189  Time 1312195163
<TZ_OK> RSSI 190  Time 1312195163
 RSSI 199  Time 1312195163
<TZ_OK> RSSI 198  Time 1312195163
<TZ_OK> RSSI 189  Time 1312195163
<TZ_OK> RSSI 189  Time 1312195164
<TZ_OK> RSSI 181  Time 1312195164
<TZ_OK> RSSI 195  Time 1312195164
<TZ_OK> RSSI 189  Time 1312195164
 RSSI 198  Time 1312195164
<TZ_OK> RSSI 193  Time 1312195164
<TZ_OK> RSSI 192  Time 1312195164
waiting for connection
<TZ_OK> RSSI 180  Time 1312195164
<TZ_OK> RSSI 195  Time 1312195164
<TZ_OK> RSSI 191  Time 1312195164
<TZ_OK> RSSI 178  Time 1312195164
<TZ_OK> RSSI 194  Time 1312195164
<TZ_OK> RSSI 191  Time 1312195164
<TZ_OK> RSSI 192  Time 1312195164
<TZ_OK> RSSI 187  Time 1312195164
<TZ_OK> RSSI 200  Time 1312195164
<TZ_OK> RSSI 193  Time 1312195165
<TZ_OK> RSSI 193  Time 1312195165
<TZ_OK> RSSI 189  Time 1312195165
<TZ_OK> RSSI 187  Time 1312195165
<TZ_OK> RSSI 199  Time 1312195165
<TZ_OK> RSSI 193  Time 1312195165
 RSSI 187  Time 1312195165
<TZ_OK> RSSI 192  Time 1312195165
<TZ_OK> RSSI 185  Time 1312195165
<TZ_OK> RSSI 199  Time 1312195165
<TZ_OK> RSSI 181  Time 1312195165
<TZ_OK> RSSI 186  Time 1312195165
<TZ_OK> RSSI 194  Time 1312195165
waiting for connection
<TZ_OK> RSSI 199  Time 1312195165
<TZ_OK> RSSI 199  Time 1312195166
 RSSI 198  Time 1312195166
<TZ_OK> RSSI 197  Time 1312195166
<TZ_OK> RSSI 181  Time 1312195166
<TZ_OK> RSSI 199  Time 1312195166
<TZ_OK> RSSI 181  Time 1312195166
<TZ_OK> RSSI 188  Time 1312195166
<TZ_OK> RSSI 185  Time 1312195166
<TZ_OK>waiting for connection

root@BlackBox01:/home/ssc/bluez_tests# 
------------rSbpI5VvDVpBVS9cvvCzQa--

