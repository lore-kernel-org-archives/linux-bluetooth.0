Return-Path: <cyrus@holtmann.org>
From: =?ISO-8859-1?Q?=C0lex?= Fiestas <afiestas@kde.org>
To: BlueZ <linux-bluetooth@vger.kernel.org>
Subject: Adapters power management
Date: Sun, 23 Mar 2014 01:42:49 +0100
Message-ID: <2963801.adpd6n3SPJ@minibad>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm finishing the port of KDE's bluez interface to BlueZ5 and I am wondering a 
few things about power management.

First thing is, why is Adapter::powered not hook into rfkill? Is there any 
difference power consumption-wise whether the power state is true or false?
I look  into the source code and only saw code to monitor the rfkill state but 
not for modifying it.

In the case that Adapter::powered has an impact on power consumption, then the 
ideal state is to have it to false as much as possible. Are there any plans to 
make that easy for frontend developers? In a sense this is very similar to 
Inhibitions in systemd[1] so I was thinking 
