Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bthid dies via kernel oops in 2.6.5
References: <200404120212.53136.cijoml@volny.cz> <1081776906.5398.112.camel@pegasus>
In-Reply-To: <1081776906.5398.112.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404121822.44231.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 12 Apr 2004 18:22:44 +0200

Hi Marcel,

preempt people told me the same as you :D They told, that this is BT 
problem :D But they are possibly right, coz kernel oopses too, when I use 
nonpreempt kernel

Michal

Dne po 12. dubna 2004 15:35 jste napsal(a):
> Hi Michal,
>
> > When I tried switch to console via ctrl+alt+del in 2.6.5, my bthid dies
> > and kernel oopses. Here is valid part of syslog. This kernel is not
> > patched with latest -mh patch.
> >
> > Apr 12 02:08:50 notas bthid[1021]: Bluetooth HID service started
> > Apr 12 02:08:53 notas bthid[1021]: Connected: Microsoft Five Button Mouse
> > (045e
> >
> > :007c)
> >
> > Apr 12 02:08:58 notas bthid[1021]: Connected: Microsoft Bluetooth
> > keyboard (045
> > e:007b)
> > Apr 12 02:09:40 notas kernel:  <1>Unable to handle kernel paging request
> > at vir
> > tual address 00100100
> > Apr 12 02:09:40 notas kernel:  printing eip:
> > Apr 12 02:09:40 notas kernel: c025087f
> > Apr 12 02:09:40 notas kernel: *pde = 00000000
> > Apr 12 02:09:40 notas kernel: Oops: 0000 [#3]
> > Apr 12 02:09:40 notas kernel: PREEMPT
> > Apr 12 02:09:40 notas kernel: CPU:    0
> > Apr 12 02:09:40 notas kernel: EIP:    0060:[<c025087f>]    Not tainted
> > Apr 12 02:09:40 notas kernel: EFLAGS: 00210246   (2.6.5)
> > Apr 12 02:09:40 notas kernel: EIP is at mousedev_event+0x83/0x20f
> > Apr 12 02:09:40 notas kernel: eax: 001000f8   ebx: 001000f8   ecx:
> > c03a7160 e
> > dx: 00100100
> > Apr 12 02:09:40 notas kernel: esi: 00000000   edi: 00000000   ebp:
> > ce3c7f24 e
> > sp: ce3c7f04
> > Apr 12 02:09:40 notas kernel: ds: 007b   es: 007b   ss: 0068
> > Apr 12 02:09:40 notas kernel: Process bthid (pid: 1021,
> > threadinfo=ce3c6000 tas                                                  
> >             k=c7a79260) Apr 12 02:09:40 notas kernel: Stack: cdbd93d4
> > 00000001 c3f9d730 c3f9d700 c03a71                                        
> >                       60 00000000 ce3c6000 c3f9d700
> > Apr 12 02:09:40 notas kernel:        c03a7160 00000000 00000001 c033dfc0
> > c3f9d7                                                               30
> > 00000000 c3af4e38 c024ef5f
> > Apr 12 02:09:40 notas kernel:        00000000 00000000 ce3c7f68 00000010
> > bffff5                                                               00
> > c9b4d400 cf8c04ae 00000000
> > Apr 12 02:09:40 notas kernel: Call Trace:
> > Apr 12 02:09:40 notas kernel:  [<c024ef5f>] input_event+0xe3/0x3dd
> > Apr 12 02:09:40 notas kernel:  [<cf8c04ae>] uinput_write+0x89/0xb5
> > [uinput] Apr 12 02:09:40 notas kernel:  [<c014b6c5>] vfs_write+0xc6/0x111
> > Apr 12 02:09:40 notas kernel:  [<c014b7a1>] sys_write+0x38/0x59
> > Apr 12 02:09:40 notas kernel:  [<c0109057>] syscall_call+0x7/0xb
> > Apr 12 02:09:40 notas kernel:
> > Apr 12 02:09:40 notas kernel: Code: 8b 40 08 0f 18 00 90 8d 41 28 39 c2
> > 75 ce 8                                                               b
> > 44 24 04 85 c0
> > Apr 12 02:09:52 notas bthid[1036]: Bluetooth HID service started
> > Apr 12 02:09:55 notas bthid[1036]: Connected: Microsoft Bluetooth
> > keyboard (045                                                            
> >   e:007b) Apr 12 02:10:24 notas bthid[1036]: Connected: Microsoft Five
> > Button Mouse (045e                                                       
> >        :007c)
>
> this is not a bug in the Bluetooth subsystem. Compile your kernel
> without preempt support and try again.
>
> Regards
>
> Marcel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
