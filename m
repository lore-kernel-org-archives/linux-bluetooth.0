Return-Path: <cyrus@holtmann.org>
To: elroy <elroy@ihug.co.nz>
Subject: Re: Ubuntu 10.04 - BlueZ 4.60 - Console-only BlueZ setup
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Date: Mon, 08 Nov 2010 08:43:51 +0100
From: =?UTF-8?Q?Jos=C3=A9_Antonio_Santos_Cadenas?= <jcaden@libresoft.es>
Cc: <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4CD7A05F.1080805@ihug.co.nz>
References: <4CD7A05F.1080805@ihug.co.nz>
Message-ID: <930b6b5d0fcdfd10087260af984b94ac@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Elroy,

On Mon, 08 Nov 2010 20:01:51 +1300, elroy <elroy@ihug.co.nz> wrote:
> Hi.
> 
> I'm trying to setup a Ubuntu 10.04 Server with a BT USB adapter to be
> able to connect and send/receive files from a cellphone.
> 
> 
> I am trying to do this setup via standard bash shell console only.
> 
> The problem I seem to be running into, is unlike the version of BlueZ
> in Ubuntu 7.04, I cannot access MAN pages for BlueZ config files
> (main.conf/etc), and am struggling to find anything that resembles
> orderly documentation on the 'Net.
> 
> So far, I can get this:
> 
> 
> 
> bluetoothd8643?: pin_code_request (sba=00:10:60:32:3A:93,
> dba=00:18:0F:DE:98:8D)
> bluetoothd8643?: No agent available for 0 request
> 
> 
> It appears as though I need some form of D-Bus software to
> communicate to BlueZ through - this seems to require a GUI - is there
> any other simpler way to do the Pairing/Config via xxx.conf files
> without having to revert back to bluez-compat?

Did you try simple-agent? It is a python scrypt in the bluez
test/folder that doesn't require any gui. I don't if Ubuntu installs it,
but if you download the source code from the web page or the git repo
you will find it. Probably with this agent you will be able to pair your
cell phone. 

> 
> 
> I have been documenting my progress so far, to try to aid others
> following my path - this may be useful to elaborate on what I am doing
> and have achieved so far.
> 
> 
> Regards,
> 
> Elroy Liddington.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

