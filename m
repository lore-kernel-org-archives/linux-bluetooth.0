Return-Path: <lintner@c-lab.de>
Message-ID: <41342BF8.2040703@c-lab.de>
Date: Tue, 31 Aug 2004 09:42:48 +0200
From: Johannes <lintner@c-lab.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with InputStream and OutputStream
References: <1324.1093866265@www49.gmx.net>	 <1093867195.5620.16.camel@pegasus>  <41331EBB.9000606@gmx.de> <1093869614.5620.24.camel@pegasus>
In-Reply-To: <1093869614.5620.24.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi,

the BTMidServ runs on the Linux side as the server.

hcitool info throws an error, although my server is running.
    gotland:~# hcitool info 00027280B16F
    Requesting information ...
    Can't create connection: Input/output error

or

    gotland:~# hcitool info 00:02:72:80:B1:6F
    Device is not available or not connected.

the hci-interface is running
    gotland:~# hciconfig hci0
    hci0:   Type: USB
        BD Address: 00:02:72:80:B1:6F ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:126 acl:0 sco:0 events:16 errors:0
        TX bytes:316 acl:0 sco:0 commands:14 errors:0


bye John



Marcel Holtmann wrote:

>Hi Johannes,
>
>  
>
>>the relevant parts of the sources are attached (the important parts are 
>>the BTMidServ.java and the method doConnect() in BTServiceSearchUI.java).
>>I hope the comments and Info-Messages will be enough declarations.
>>
>>I use Debian Linux with a 2.6.7 Kernel and KDE version 3.2.3.
>>The phone is a Siemens SX1 with firmwareversion 10. It uses a Symbian OS 
>>Serie 60.
>>The USB-dongle is from Acer and should be supported from BlueZ.
>>    
>>
>
>and what do you use on the Linux side? Please run a "hcitool info ..."
>as root for me.
>
>Regards
>
>Marcel
>
>  
>
