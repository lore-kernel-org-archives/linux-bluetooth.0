Return-Path: <linux-kernel-owner+marcel=40holtmann.org-S1161471AbWALXdm@vger.kernel.org>
From: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: patch: problem with sco
Date: Fri, 13 Jan 2006 00:33:39 +0100
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        maxk@qualcomm.com
References: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de> <1137057244.3955.3.camel@localhost.localdomain> <200601130031.22063.wolfgang.walter@studentenwerk.mhn.de>
In-Reply-To: <200601130031.22063.wolfgang.walter@studentenwerk.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200601130033.39804.wolfgang.walter@studentenwerk.mhn.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <bluez-devel.lists.sourceforge.net>

Am Freitag, 13. Januar 2006 00:31 schrieb Wolfgang Walter:
> Hi Marcel,
>
>
> >/usr/sbin/hciconfig -a
>
> hci0:   Type: USB
>         BD Address: 00:00:3A:6A:18:D1 ACL MTU: 1017:8 SCO MTU: 64:8

SCO MTU: 64:8 because is of our patch. Without patch it is 64:0

-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
Leiter EDV
Leopoldstraße 15
80802 München
Tel: +49 89 38196 276
Fax: +49 89 38196 144
wolfgang.walter@studentenwerk.mhn.de
http://www.studentenwerk.mhn.de/
