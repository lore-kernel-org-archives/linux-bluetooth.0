Return-Path: <cyrus@holtmann.org>
Message-ID: <4AB0D92A.6000205@charter.net>
Date: Wed, 16 Sep 2009 08:25:14 -0400
From: Peter Hurley <phurley@charter.net>
MIME-Version: 1.0
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Install of conf files
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following source config files are not installed during make install:
    audio/audio.conf
    network/network.conf
    serial/serial.conf
    input/input.conf
Why are main.conf & rfcomm.conf the only conf files that are installed? 
(I suspect that it's an oversight and these files should be listed as 
conf_DATA in Makefile.am)

Regards,
Peter Hurley
