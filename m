Return-Path: <cyrus@holtmann.org>
Subject: Re:
 bluetooth-fix-for-acer-bluetooth-optical-rechargeable-mouse.patch
From: Marcel Holtmann <marcel@holtmann.org>
To: Lamarque Vieira Souza <lamarque@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <200908062005.17141.lamarque@gmail.com>
References: <20090806154448.119b9e82.akpm@linux-foundation.org>
	 <200908062005.17141.lamarque@gmail.com>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 17:39:49 -0700
Message-Id: <1249605589.21101.41.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lamarque,

first of all this is not a top-posting mailing list. Use proper quoting
like everybody else.

> 	Well,	I need this patch or my bluetooth mouse is completly useless to me. If 
> Marcel could show me how I can solve this problem in right way I can update 
> the patch. As I said in another e-mail, I do not see anywhere else I can make 
> the driver use input session instead of hid session beside hidp/core.c. I have 
> tried to add a HID quirk in HID subsystem, but I have failed to find a place 
> to change the input session types. Anyway, as far as I can see this is not a 
> HID quirk, it is a quirk to avoid using HID session, so I do not see why I 
> must use a HID quirk as Marcel suggested.

And second of all this should be solved via the HID subsystem. Since you
clearly have a problem with the HID mode of your mouse. You are just
hacking around the real issue. And I am not accepting this patch. Mail
your problem to the input mailing list:

HID CORE LAYER
M:      Jiri Kosina <jkosina@suse.cz>
L:      linux-input@vger.kernel.org

Regards

Marcel


