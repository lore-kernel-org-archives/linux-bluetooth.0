Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 17 Aug 2012 13:30:38 +0200
Message-ID: <CAAHv3KHnRM=7WYgy-teqUZfFYNoGPdkOb0dgf3t4XiuYtoUOOA@mail.gmail.com>
Subject: Setting up an A2DP server
From: Niklas Claesson <nicke.claesson@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I would like to use a computer as an A2DP sink (bluetooth devices
should be able to play through the computers speakers). So far I can
manually connect from the computer using dbus signals with bluez/pulse
(org.bluez.AudioSource). But what I really want is for the external
device to connect to my service. The goal is to let anyone with
bluetooth play music in our common space at the university.

What would be the most straight forward way to implement this?

Med vänliga hälsningar
Niklas Claesson
