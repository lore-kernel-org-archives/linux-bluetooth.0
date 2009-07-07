Return-Path: <cyrus@holtmann.org>
Date: Tue, 07 Jul 2009 10:47:54 +0900
From: Chan-Yeol Park <chanyeol.park@samsung.com>
Subject: Sony Erricson Headset compatibility Problem.
To: 'Marcel Holtmann' <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-id: <001301c9fea4$f1bb10b0$d5313210$%park@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Marcel

BlueZ Wiki site the following is written.

The Sony Ericsson HBH-DS970 and HBH-DS980 are not compliant with the
bluetooth spec. Currently, they do not work well with bluez, but a
workaround is in development.
http://wiki.bluez.org/wiki/MotorolaHBHDS9x0


As far as I know, BlueZ wiki site was used for BlueZ 3.xx
However even if I use with BlueZ 4.44(latest), they do not work well..

If you know the workaround your site mentioned , could you explain that for
me?

What I found is below. 

After HFP RFCOMM connection and 10 seconds later,
A2DP session is so slow.. MTU is so small and their respond is too late.

I guess that in case of another phone, it's no problem because their
connections(HFP,A2DP)are made simultaneously.
However in BlueZ case HFP,A2DP connection is separated. As a result it takes
more time to connect stereo Headset A2DP service than another device. 


Regards 
Chanyeol

