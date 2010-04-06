Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <r2if3ae2ce11004061001mc539e7eaq206d43ffb12fb2d2@mail.gmail.com>
References: <r2if3ae2ce11004061001mc539e7eaq206d43ffb12fb2d2@mail.gmail.com>
From: Garry Paxinos <paxinos@gmail.com>
Date: Tue, 6 Apr 2010 13:08:32 -0400
Message-ID: <j2tf3ae2ce11004061008x26da852el996b017a5115d595@mail.gmail.com>
Subject: Re: upper limit of bonded devices?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Is there a practical upper limit of the number of devices that can be
bonded to a single computer?

I am considering reworking the bonding code to use a MySQL DB to store
the list of devices, but was wondering if there was any other limit
(either coding or practical).   For example, can a single computer
bond with 1k devices?  what about 100K or even 1M ?

Thanks,
Pax.
