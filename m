Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Sep 2009 13:54:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nick Davies <nickavies@yahoo.com>
Cc: Iain Hibbert <plunky@rya-online.net>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Volume control for headset
Message-ID: <20090925105441.GA19339@jh-x301>
References: <418098.94079.qm@web112804.mail.gq1.yahoo.com> <1253864301.981724.225.nullmailer@galant.ukfsn.org> <807937.34864.qm@web112809.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <807937.34864.qm@web112809.mail.gq1.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 25, 2009, Nick Davies wrote:
>   OK, but I don't know where the RFCOMM socket is created,

audio/headset.c

>   how can I connect to existing socket?

You can't really but you also shouldn't need to. You can request
bluetoothd to change the volume using the SetProperty("SpeakerGain", 0-15)
method on the org.bluez.Headset interface on the D-Bus object that
represents your headset. There's a python script in the bluez source that
lets you do it too, e.g:

test/test-telephony <remote address> speakergain 10
test/test-telephony <remote address> microphonegain 5

Johan
