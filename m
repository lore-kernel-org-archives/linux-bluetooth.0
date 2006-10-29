Return-Path: <jpf321@gmail.com>
From: "JP Freeley (GMAIL-NYC)" <jpf321@gmail.com>
Subject: Re: [Bluez-devel] intermittent ISCAN functionality
Date: 29 Oct 2006 16:36:00 -0500
To: <marcel@holtmann.org>
Message-ID: <3244984569.792757@relay.pair.com>
CC: <bluez-devel@lists.sourceforge.net>
List-ID: <bluez-devel.lists.sourceforge.net>

Not running a gui environ
is there another way?
-----Original Message-----
From: Marcel Holtmann <marcel@holtmann.org>
Date: Sunday, Oct 29, 2006 3:12 pm
Subject: Re: [Bluez-devel] intermittent ISCAN functionality

Hi,

> I seem to be having a problem with ISCAN. Sometimes it is initiated, 
 sometimes it is not. I have to run several hciconfig down/up commands 
 until I can see ISCAN in hciconfig -a output. Obviously my hcid.conf is 
 set up properly (unedited debian sid version) or else I would never see 
 ISCAN.

install bluez-gnome-0.6 and use the Bluetooth preferences application to disable the automatic switching back into non-discoverable mode.

Regards

Marcel



------------------------------------------------------------------------- Using Tomcat but need to do more? Need to support web services, security? Get stuff done quickly with pre-integrated technology to make your job easier Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
