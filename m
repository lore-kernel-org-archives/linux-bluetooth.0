Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] another oops with bthid and 2.6.5
References: <200404122330.11760.cijoml@volny.cz> <1081810426.8634.28.camel@pegasus>
In-Reply-To: <1081810426.8634.28.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404130755.36353.cijoml@volny.cz>
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
Date: Tue, 13 Apr 2004 07:55:35 +0200

Dne =FAt 13. dubna 2004 00:53 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > when normal work when I sometimes move mouse, kernel oopses with this
> > oops:
> >
> > Code:  Bad EIP value.
> >  <1>Unable to handle kernel NULL pointer dereference at virtual address
> > 00000004
> >  printing eip:
> > 00000004
> > *pde =3D 00000000
> > Oops: 0000 [#5]
> > CPU:    0
> > EIP:    0060:[<00000004>]    Not tainted
> > EFLAGS: 00010006   (2.6.5)
> > EIP is at 0x4
> > eax: c0328644   ebx: c0328644   ecx: 00000000   edx: 00000003
> > esi: c02d1adf   edi: c0326c50   ebp: cd989db8   esp: cd989d9c
> > ds: 007b   es: 007b   ss: 0068
> > Process bthid (pid: 553, threadinfo=3Dcd988000 task=3Dcd9dd160)
> > Stack: c01185ab 000001a4 00000001 00000003 00000286 ceecc1c0 c8637a14
> > cd989dc8 c01185e6 00000000 c863a800 c8646380 cf8c6108 c015a0de 00000246
> > c863a800 cf8c66a6 c8715780 c01465fb c8715780 00000000 cde23580 cde23580
> > c0145070 Call Trace:
> >  [<c01185ab>] __wake_up_common+0x2d/0x50
> >  [<c01185e6>] __wake_up+0x18/0x21
> >  [<cf8c6108>] uinput_destroy_device+0x17/0x41 [uinput]
> >  [<c015a0de>] iput+0x4c/0x5e
> >  [<cf8c66a6>] uinput_burn_device+0x23/0x25 [uinput]
> >  [<c01465fb>] __fput+0xd6/0xe7
> >  [<c0145070>] filp_close+0x4f/0x7a
> >  [<c011c1fc>] put_files_struct+0x7e/0xd2
> >  [<c011cc8f>] do_exit+0x146/0x30e
> >  [<c01095e9>] do_divide_error+0x0/0xd3
> >  [<c0116a75>] do_page_fault+0x23e/0x4c1
> >  [<c0118572>] default_wake_function+0x0/0xc
> >  [<c01271db>] call_usermodehelper+0xac/0xb5
> >  [<c01270ec>] __call_usermodehelper+0x0/0x43
> >  [<c01ae44f>] vsnprintf+0x24b/0x4b9
> >  [<c0116837>] do_page_fault+0x0/0x4c1
> >  [<c0108ff1>] error_code+0x2d/0x38
> >  [<c01185ab>] __wake_up_common+0x2d/0x50
> >  [<c01185e6>] __wake_up+0x18/0x21
> >  [<cf8c6108>] uinput_destroy_device+0x17/0x41 [uinput]
> >  [<cf8c66a6>] uinput_burn_device+0x23/0x25 [uinput]
> >  [<c01465fb>] __fput+0xd6/0xe7
> >  [<c0145070>] filp_close+0x4f/0x7a
> >  [<c0108e47>] syscall_call+0x7/0xb
> >
> > Code:  Bad EIP value.
>
> looks like there is a bug somewhere in the uinput driver. From a first
> review I can't find anything. Please add some printk debugging statement
> to the uinput driver, so we can track down where the problem is and
> under what circumstances it occurs.
>
> Regards
>
> Marcel

I forgot to say, that this oops happens when preempt is switched off

Michal


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
