Return-Path: <cyrus@holtmann.org>
From: Nicola Ranaldo <ranaldo@unina.it>
To: linux-bluetooth@vger.kernel.org
Subject: Bnep, dhcp and other issues
Date: Tue, 3 Mar 2009 17:35:17 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200903031735.17328.ranaldo@unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!
When a bnep connection is established I have to delay the startup of dhcp on 
the client side by about 5/10 seconds or I get a timeout without lease.
This happens both on gentoo and on Openmoko freerunner (SHR/FSO).

On the last I have another problem and I do not know if it's related to the 
first or is Angstrom dependent, when the bnep connection is established the 
bnep interface goes up immediately, so the udev script ignores the interface 
and does not configure it at all. 

Is this a known issue?

Regards

	Nicola Ranaldo
