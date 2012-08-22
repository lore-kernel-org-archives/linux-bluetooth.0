Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1345651474.29868.344.camel@pohly-mobl1.fritz.box>
References: <1345651474.29868.344.camel@pohly-mobl1.fritz.box>
Date: Thu, 23 Aug 2012 01:13:11 +0300
Message-ID: <CABBYNZL_P-if4JxM5K8jXvc86aJWXPfoY2xJAGpSV784XWABww@mail.gmail.com>
Subject: Re: PBAP + two-step download
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Bluez <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Jeremy Whiting <jpwhiting@kde.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

On Wed, Aug 22, 2012 at 7:04 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> Hello!
>
> For IVI use cases, Mikel and I were discussing how a phone's address
> book could be cached intelligently by an IVI head unit. The rough idea
> is that first all contacts get pulled without PHOTO data. This data is
> used to match the current phone address book with some potentially
> cached local data. Then in a second step, the PHOTO data of all contacts
> is requested (*). This is all done in the same PBAP session, so the
> numbering of contacts is the same in both steps.
>
> The goal is to get the essential data (names, phone numbers) quickly and
> then add pictures later on.

I think it is a good idea, but what about to download the full contact
vcard only when it is to be displayed? When we connect we attempt to
download the full phonebook which is cached for fast lookup but while
ringing we can download the full vcard including the picture. A single
vcard should be really fast specially since we are already connected
and should have a session active, in any case this would have to be
done if the contact is not found locally we should stop any ongoing
operation and attempt to search for the phone number.

-- 
Luiz Augusto von Dentz
