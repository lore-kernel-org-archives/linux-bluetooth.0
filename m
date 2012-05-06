Return-Path: <cyrus@holtmann.org>
Message-ID: <4FA6C460.9010209@tu-ilmenau.de>
Date: Sun, 06 May 2012 20:35:12 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Can't connect Bluetooth Devices
References: <4F968FF7.7060303@tu-ilmenau.de> <4FA1BB1C.6060409@tu-ilmenau.de> <20120502225815.GE16030@joana> <4FA23B93.8090204@tu-ilmenau.de> <20120503094429.GA6226@x220>
In-Reply-To: <20120503094429.GA6226@x220>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Am 03.05.2012 11:44, schrieb Johan Hedberg:
> Hi Steffen,
>
> On Thu, May 03, 2012, Steffen Becker wrote:
>>> A linkkey is created during the pairing procedure, just pair your
>>> devices and you will be done.
>>> And let only bluetoothd touch the /var/lib/bluetooth
>>> directory, don't touch there yourself.
>>>
>>> 	Gustavo
>> Thanks for your fast reply, but that's exactly what I don't know:
>> How can I pair my devices?
> You pair using the CreatePairedDevice D-Bus method that BlueZ provides.
> There are various front-ends that you can use to call this method. If
> you've got GNOME installed then a pairing wizard should be just a few
> mouse clicks away through the Bluetooth icon in the upper right-hand
> corner. If you've only got the command line you can use e.g. the
> simple-agent python script (under the test subdirectory):
>
> 	test/simple-agent hci0<remote address>
>
> Btw, is there something that the network plugin (which you can operate
> using e.g. test/test-network) doesn't provide but pand does? We'll
> probably remove pand from the source tree along with BlueZ 5.0 so it'd
> be good to know any deficiencies it has.
>
> Johan

Sorry for this late answer and thank you for that hint; but I haven't 
tried it yet - will do this tomorrow.

To your question:
There are some special things I want to do using the pand-command 
(because it worked well the last years with that):
1.) Using the "iperf" command to display & compare the data rate of a) a 
bluetooth1.0-Dongle and b) a bluetooth3.0-Dongle
2.) Using the "iperf" command between two bluetooth-devices and at the 
same time also using the "iperf"-command between two WLAN-devices (2 
PC's: at each PC one bluetooth-device & one WLAN-Stick) -> With a 
sniffing tool I want to check the AFH of Bluetooth.
3.) Send a "big" (media-)file to show how Bluetooth3.0 uses the "WLAN"-mode.

Is all this possible without pand-connection? If yes - how?

Reagrds,
Steffen
