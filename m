Return-Path: <survivor@uni-paderborn.de>
Message-ID: <4060660E.5050004@uni-paderborn.de>
Date: Tue, 23 Mar 2004 17:30:06 +0100
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Xavier Garreau <x.garreau@prim-time.fr>
CC: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Accessing HCI on Windows
References: <405FFCB9.5050507@uni-paderborn.de> <1080040266.2663.317.camel@pegasus> <021901c410d8$724c2630$b67ba8c0@zaz1>
In-Reply-To: <021901c410d8$724c2630$b67ba8c0@zaz1>
Content-Type: text/html; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body>
Hello Xavier!<br>
<br>
Xavier Garreau schrieb:<br>
<blockquote cite="mid021901c410d8$724c2630$b67ba8c0@zaz1" type="cite">
  <blockquote type="cite">
    <pre wrap="">as I know there is no Windows stack that provides full access to the HCI
layer as BlueZ do. Actually it must be possible in some kind of way, but
in most cases you have to pay for their development kit.
    </pre>
  </blockquote>
  <pre wrap=""><!---->

The COM1 stack used to allow direct HCI access (H4 interface) if opening as
a serial port the special file declared in
HKLM\SYSTEM\CurrentControlSet\Enum\USB\Vid_xxxx&amp;Pid_xxxx\something_goes_here
\Device Parameters\SymbolicName
(replace Vid_xxxx&amp;Pid_xxxx with the ones from your device)
  </pre>
</blockquote>
Do I understand correctly that an USB Bluetooth dongle can be treated
as if it was connected to the serial port of the pc? In this case
calling the Windows API Function CreateFile(SymbolicName) and doing
ReadFile() and WriteFile() according to H4 would do the job, wouldn't
it?<br>
<blockquote cite="mid021901c410d8$724c2630$b67ba8c0@zaz1" type="cite">
  <pre wrap="">You can download their drivers from their website et make it work with your
dongle by editing the .inf file to add YOUR dongle vid&amp;pid.
  </pre>
</blockquote>
By "their" you mean Widcomm? Ok, my Dongles are shipped with Widcomm
drivers, so I don't have to change the .inf file, correct?<br>
<br>
I've located the corresponding registry entry and will test it.<br>
<blockquote cite="mid021901c410d8$724c2630$b67ba8c0@zaz1" type="cite">
  <pre wrap="">Just kill their btstack and write your own...

It's surely not usable for commercial products </pre>
</blockquote>
Why not? If my dongle comes with Widcomm drivers, I don's see any
reason why my app shouldn't be allowed to write to use them. Anyway, my
work will be open source.<br>
<blockquote cite="mid021901c410d8$724c2630$b67ba8c0@zaz1" type="cite">
  <pre wrap="">but it works for
testing/development purposes ... I used it to create some demos but am now
working with widcomm SDK which gives acces to all levels of the stack
beginning from l2cap (or HCI vendor commands)
  </pre>
</blockquote>
We consider licensing this SDK, too. Is it well documented?<br>
<blockquote cite="mid021901c410d8$724c2630$b67ba8c0@zaz1" type="cite">
  <pre wrap="">Hope it helps.

  </pre>
</blockquote>
Yes, I think it really does a lot! Thanks a lot! <br>
You don't have some example code within reach by any chance ;-). Would
be really cool!<br>
<br>
Kind regards<br>
Stefan<br>
<br>
</body>
</html>
