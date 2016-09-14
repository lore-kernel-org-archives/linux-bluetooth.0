Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 14 Sep 2016 11:59:10 -0400
From: Don Zickus <dzickus@redhat.com>
To: linux-bluetooth@vger.kernel.org
Subject: using d-bus api to set security level
Message-ID: <20160914155910.GC98438@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am trying to find the equivalent of using gatttool's --sec-level when
writing a python script to connect to an LE device over the d-bus API.

It seems like I have to set the Characteristic correctly.  But I am missing
something obvious when looking through the doc/ api files.

Can someone point me to the right spot?  Thanks!

Cheers,
Don

