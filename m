Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC][PATCH] bluetooth: hci_sysfs: Ensure sysfs add/del is
 pre-empt safe
From: Marcel Holtmann <marcel@holtmann.org>
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <49F05193.7070609@nokia.com>
References: <49F05193.7070609@nokia.com>
Content-Type: text/plain
Date: Thu, 23 Apr 2009 12:42:31 +0100
Message-Id: <1240486951.15894.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Roger,

> Subject: [PATCH] bluetooth: hci_sysfs: Ensure sysfs add/del is pre-empt safe
> 
> Uses different work_struct variables for add_conn() and del_conn(). Uses
> single work queue instead of two for adding and deleting connections.
> 
> It eliminates the following error on a pre-emptible kernel.

patch looks good to me. Can you just please replace the work queue name
with "bluetooth" instead if "btworkq". Looks more saner to me.

Regards

Marcel


