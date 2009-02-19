Return-Path: <cyrus@holtmann.org>
Subject: Re: Qualifying AVCTP and AVDTP
From: Marcel Holtmann <marcel@holtmann.org>
To: Krishnan R <r_krish@email.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090219060851.88E6C326774@ws1-8.us4.outblaze.com>
References: <20090219060851.88E6C326774@ws1-8.us4.outblaze.com>
Content-Type: text/plain
Date: Thu, 19 Feb 2009 07:35:33 +0100
Message-Id: <1235025333.4640.1.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Krishnan,

> How do we qualify AVCTP and AVDTP? Not all test cases of these protocols can be simulated through AVRCP and A2DP. Any hints on qualifying these two protocols? Do we have some stubs to do these?

you have to write a program that tests the valid and invalid test cases
of AVDTP and AVCTP. Then the HCI or air traces have to be captured and
evaluated by a BQE to proof correct behavior.

Regards

Marcel


