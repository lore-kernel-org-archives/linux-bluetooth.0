Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Jan 2009 10:23:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Disconnect eSCO link from Command line
Message-ID: <20090128082323.GA8865@jh-x301>
References: <c2a31c480901272116y2bd70ed3yf1c02009c1ec0fd0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c2a31c480901272116y2bd70ed3yf1c02009c1ec0fd0@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 28, 2009, sreevani medhahal wrote:
>   After the headset has created the eSCO link. The Profile Tuning
> Suite asks for Closing the Audio Connection from AG. Is there any
> command line utiility to disable the eSCO link & not the service level
> connection(ACL).[The eSCO link is visible on giving hcitool con ]

You can do that by calling the Stop D-Bus method call on the
org.bluez.Headset interface of the corresponding device object. You can
e.g. use the test/test-telephony python script for this:
./test-telephony stop <remote address>

Johan
