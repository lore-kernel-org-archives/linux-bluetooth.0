Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130322105516.GB10769@x220.ger.corp.intel.com>
References: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1363678855-12765-3-git-send-email-mikel.astiz.oss@gmail.com>
	<20130322105516.GB10769@x220.ger.corp.intel.com>
Date: Fri, 22 Mar 2013 13:33:40 +0100
Message-ID: <CANT-zCX6qx5=oCsscMr=tqrHxTCqKsvWuWO7fmjt_YPkUUAY1A@mail.gmail.com>
Subject: Re: [RFC v0 02/11] device: Use btd_service to represent profiles
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Mar 22, 2013 at 11:55 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Mikel,
>
> On Tue, Mar 19, 2013, Mikel Astiz wrote:
>> +static gint service_profile_cmp(gconstpointer a, gconstpointer b)
>> +{
>> +     struct btd_service *service = (gpointer) a;
>> +     struct btd_profile *profile = (gpointer) b;
>
> Instead of this explicit casting why not declare the local variables
> const too?

In order to do this (at least in the case of b) I'd have to add a
const version of service_get_profile(). However, profile.h doesn't
define any semantics for a const profile (and neither does device.h),
so I would discourage adding a function such as:

struct btd_profile *service_get_profile(const struct btd_service *service);

I therefore though it wasn't worth making the API more complex in
order to have such a comparison function. If you still want this, a
possible alternative would be to extend the API with:

const struct btd_profile *service_get_profile_const(const struct
btd_service *service);
const struct btd_device *service_get_device_const(const struct
btd_service *service);

Cheers,
Mikel
