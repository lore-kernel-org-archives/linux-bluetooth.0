Return-Path: <cyrus@holtmann.org>
Message-ID: <486561.68367.qm@web112806.mail.gq1.yahoo.com>
References: <418098.94079.qm@web112804.mail.gq1.yahoo.com> <1253864301.981724.225.nullmailer@galant.ukfsn.org> <807937.34864.qm@web112809.mail.gq1.yahoo.com> <20090925105441.GA19339@jh-x301>
Date: Fri, 25 Sep 2009 05:09:03 -0700 (PDT)
From: Nick Davies <nickavies@yahoo.com>
Subject: Re: Volume control for headset
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090925105441.GA19339@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

  I'd like to provide you more details about my current situation: 
  I download the btsco-5.0 , use the old bt-sco module and daemon to connect the headset with my PC, then I can hear the sound from my headset, but it's not available to control the volume from my PC.  So I start to debug this issue.
  With Iain's help,  I add some codes to send the volume value to the RFCOMM socket after the socket is created by the daemon:

+   char vol[20];
+      int value = 1;
+   int ret;
+   if((value >= 0) && (value <= 15)) {
+       sprintf(vol, "\r\n+VGS=%d\r\n", value);
+       ret = send(socket_name, vol, strlen(vol), MSG_NOSIGNAL); 
+   }
  
  I checked the ret value, it's OK, but the headset value isn't changed to 1. Is there something wrong with my approach? Or the signal I've sent is not correct?  
 
Best regards,
Nick 



> audio/headset.c
> 
> >   how can I connect to existing socket?
> 
> You can't really but you also shouldn't need to. You can request
> bluetoothd to change the volume using the SetProperty("SpeakerGain", 0-15)
> method on the org.bluez.Headset interface on the D-Bus object that
> represents your headset. There's a python script in the bluez source that
> lets you do it too, e.g:
> 
> test/test-telephony speakergain 10
> test/test-telephony microphonegain 5
> 
> Johan



      

