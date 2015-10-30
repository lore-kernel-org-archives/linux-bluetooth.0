Return-Path: <cyrus@holtmann.org>
From: Adam Moore <adam.moore@savantsystems.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Pacho Ramos <pacho@gentoo.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Should btmgmt be installed?
Date: Fri, 30 Oct 2015 16:31:57 +0000
Message-ID: <D2591198.1754F%adam.moore@savant.com>
References: <1446017598.18413.23.camel@gentoo.org>
 <20151030120053.GA10576@t440s.lan>
In-Reply-To: <20151030120053.GA10576@t440s.lan>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Seems like if the potentially dangerous hcitool is still installed, there
would be no harm in installing btmgmt - perhaps long term btmgmt should be
installed instead of hcitool.

On 10/30/15, 8:00 AM, "linux-bluetooth-owner@vger.kernel.org on behalf of
Johan Hedberg" <linux-bluetooth-owner@vger.kernel.org on behalf of
johan.hedberg@gmail.com> wrote:

>Hi Pacho,
>
>On Wed, Oct 28, 2015, Pacho Ramos wrote:
>> Some people downstream is asking us to install btmgmt utility but, for
>> some reason, it looks like upstream makefile rules don't install it. Is
>> that being missed on purpose? Should Makefiles be fixed to get it
>> installed or that utility is not meant to be installed in users
>> systems?
>
>I think this is mostly because of historical reasons. The btmgmt tool
>wasn't created for anything else except a developer testing tool
>initially. It's still supposed to be just a developer tool, but if
>people have good reasons to use it then I don't personally have anything
>against making it installable through the makefile rules. Someone should
>just send a patch for it. That said, Marcel might have a differing
>opinion on the matter (though his silence so far is promising ;)
>
>Johan
>--
>To unsubscribe from this list: send the line "unsubscribe
>linux-bluetooth" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html


Statement of Confidentiality

The contents of this e-mail message and any attachments are confidential and are intended solely for the addressee. The information may also be legally privileged. This transmission is sent in trust, and the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or at 508.683.2500 and delete this message and its attachments, if any.

