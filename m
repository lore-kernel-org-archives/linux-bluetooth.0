Return-Path: <cyrus@holtmann.org>
Message-ID: <6F8E4829F275487887832A64E4125229@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: FYI, regarding AVRCP
Date: Fri, 19 Dec 2008 20:24:36 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel, Johan, et al,

Since our meeting in PortlandI have been busy dealing with both "day 
job" issues, as well as finishing up some Intellectual Property issues 
surrounding my ongoing evening/weekend project, of which AVRCP and my 
remote are a small but critical part.  Within the next two weeks I will 
reengage AVRCP and expect to soon bring it up to 1.3 (metadata transfer) 
as we discussed in Portland.  Sorry it has taken so long.

With regard to the question from Park Chan-Yeol, I suggest we consider a 
Bluez/DBUS "version" property (for simplicity, a String) for the 
org.bluez.Control interface, to allow users to know just what they are 
dealing with.  Any thoughts?

David Stockwell 

