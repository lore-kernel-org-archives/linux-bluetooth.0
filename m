Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <7.0.0.16.0.20051227185442.01a979c8@unizar.es>
To: bluez-users@lists.sourceforge.net
From: Nacho Alastruey =?iso-8859-1?Q?Bened=E9?= <nacho.alastruey@unizar.es>
Subject: Re: [Bluez-users] don't find the module "snd_bt_sco"
In-Reply-To: <43A319B5.9040100@bglug.it>
References: <20051216103855.90185.qmail@web36113.mail.mud.yahoo.com>
 <43A319B5.9040100@bglug.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 27 Dec 2005 19:01:16 +0100

Hello:

I'm having the same problem. I try to install the=20
last version of btsco but I cannot find the=20
module"snd-bt-sco.ko" to follow the steps you provide.

When I try to "modprobe snd-bt-sco" I get "Module snd_bt_sco not found"

When I run "btsco" I get:

  " Error: hwdep next device (hw:0): Operation not permitted
    Error: hwdep next device (hw:1): Operation not permitted
    Error: control open (hw:2): No such file or directory
    Error: Can't find device. Bail"

Thanks in advance for your help.

Nacho

At 20:47 16/12/2005, you wrote:
>Swathi Mathur80 ha scritto:
>>I am unable to find the module "snd_bt_sco". Where can i find this module=
 ?
>>Do you think i might have made any mistake in=20
>>any of the steps which are executed before.
>>Can anyone help me with this.
>
>I also had some problem because the "make install" couldn't copy the=
 module.
>
>If it was compiled correctly by "make" you may=20
>find the module "snd-bt-sco.ko" under btsco/kernel
>
>You shall create the directory=20
>"/lib/modules/KERNELVERSION/extra", where=20
>KERNELVERSION is the kernel that you booted, and=20
>copy inside it the module. After that "modprobe=20
>snd-bt-sco" should work correctly.
>
>Jimmi
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Splunk Inc. Do you grep through log=
 files
>for problems?  Stop!  Download the new AJAX search engine that makes
>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users

--=20
____________________________________________________________

Nacho Alastruey Bened=E9

Laboratorio de Redes y Servicios M=F3viles
Instituto de Investigaci=F3n de Ingenier=EDa de Arag=F3n, I3A
Laboratorios Universidad de Zaragoza P.T. Walqa
Crrtra. Zaragoza Nacional 330a Km.566
22197 Cuarte (HUESCA)
Tfno.: +34 974 299207
e-mail: nacho.alastruey@unizar.es
http://redesmoviles.unizar.es
_____________________________________________________________=20



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
