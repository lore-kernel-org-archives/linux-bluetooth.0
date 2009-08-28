Return-Path: <cyrus@holtmann.org>
Message-ID: <377658.93129.qm@web94901.mail.in2.yahoo.com>
References: <639511.66794.qm@web94914.mail.in2.yahoo.com>  <1251309784.2950.95.camel@localhost.localdomain>  <302064.78581.qm@web94908.mail.in2.yahoo.com> <1251401348.2950.121.camel@localhost.localdomain>
Date: Fri, 28 Aug 2009 10:57:59 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: Re: shared hci transport
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1251401348.2950.121.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

----- Original Message ----=0AFrom: Marcel Holtmann <marcel@holtmann.org>=
=0ATo: Pavan Savoy <pavan_savoy@yahoo.co.in>=0ACc: linux-bluetooth@vger.ker=
nel.org=0ASent: Friday, 28 August, 2009 12:59:08 AM=0ASubject: Re: shared h=
ci transport=0A=0AHi Pavan,=0A=0Aplease don't do top-posting on this mailin=
g list. We want proper inline=0Aquoting.=0A=0A> sure.=0A> the bcm4325 has u=
art transport for BT [so I can make use of hci_h4, say by hciattach - like =
bcm2035].=0A> The FM core understands hci-vendor specific command.=0A> =0A>=
 for example, I send HCI_VS opcode=3D0x20 to set the power of Rx to On.[The=
 power on sequence also involves download of a firmware which is nothing bu=
t a file with ~10/20 hci-vendor specific commands with different opcodes].=
=0A> opcode 0x0a (say) to set the frequency and similarly in opcode 0x1d [a=
udio enable] I give an data arguement 0x01 or 0x02 to say to FM Rx to put o=
ut audio on either it's analog lines or digital [i2s] lines..=0A> =0A> Curr=
ently my fm stack, application is making use of hci_open_dev, send_cmd kind=
 of hci lib calls to send commands.=0A> =0A> Now what should be my approach=
 to send in same sort of commands from the kernel space ?=0A=0A>For the fir=
mware loading part, we have to change this whole driver model=0A>and add an=
 init stage that allows configuration etc.=0A=0A>I am not sold on the whole=
 in-kernel approach for FM yet. We need to=0A>talk more about it. Especiall=
y since vendor commands and messing with=0A>the flow control is tricky.=0A=
=0A>Regards=0A=0A>Marcel=0A=0AYes -- Sorry for top posting [unfortunately t=
his dumb mail editor doesn't give me much of choice]=0AIn any case,=0A=0AI =
was thinking more in terms of hci_device and hci_driver kind of a model, wh=
ere in there can be a hci_device for a transport [say HCI-UART] and multipl=
e hci_driver(s) for 1 such hci_device -- these hci_drivers get registered t=
o a main/single hci_device.=0A=0Ahci_device {=0Aopen,send_frame, notify, fl=
ush, close=0A}=0A=0Aand the new hci_driver {=0Apre/post_open,  -- can be us=
ed for a f/w download=0Apre/post_send, -- can be used to packetize/depacket=
ize=0Apre/post_notify, -- events can be categorised to HCI [cmd complete] s=
ort of events or processed locally and not be notified to hci-user space la=
yer..=0Apre/post_flush and =0Apre/post_close=0A}=0A=0AIt would be same as u=
sing line discipline driver over uart. Every HCI transfer send or recieve c=
an have a pre/post function of an already registered "hci_driver" which nee=
ds to called.=0A=0AWe would kind of make use for plenty of other purpose al=
so, since the transports are being shared for all sort of devices nowadays =
[gps+bt on uart/usb, fm+bt on uart].=0A=0A=0A=0A--=0ATo unsubscribe from th=
is list: send the line "unsubscribe linux-bluetooth" in=0Athe body of a mes=
sage to majordomo@vger.kernel.org=0AMore majordomo info at  http://vger.ker=
nel.org/majordomo-info.html=0A=0A=0A=0A      Love Cricket? Check out live s=
cores, photos, video highlights and more. Click here http://cricket.yahoo.c=
om
