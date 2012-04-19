Return-Path: <cyrus@holtmann.org>
Message-ID: <4F901F69.4000304@sipsolutions.net>
Date: Thu, 19 Apr 2012 07:21:29 -0700
From: Johannes Berg <johannes@sipsolutions.net>
MIME-Version: 1.0
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [RFCv1] mac80211: Adds Software / Virtual AMP 80211
References: <4F84A422.3030900@sipsolutions.net> <4F84A52A.7050905@sipsolutions.net> <20120411071119.GC17779@aemeltch-MOBL1> <1334714611.3725.34.camel@jlt3.sipsolutions.net> <20120418121551.GE19228@aemeltch-MOBL1> <4F8ED1D0.1070401@sipsolutions.net> <20120418145202.GH19228@aemeltch-MOBL1> <4F8ED913.4040807@sipsolutions.net> <20120419063558.GA16002@aemeltch-MOBL1> <4F9012E9.1040409@sipsolutions.net> <20120419133907.GD16002@aemeltch-MOBL1>
In-Reply-To: <20120419133907.GD16002@aemeltch-MOBL1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 4/19/2012 6:39 AM, Andrei Emeltchenko wrote:
>> You cannot use more than one channel today. We are changing that. To
>> do good channel management, rather than hard-coding it in your
>> config, you want to run a single wpa_s controlling all interfaces.
>
> Can wpa_supplicant be an AP? I though that functionality is split to
> hostap and wpa_supplicant.

Yes, it can.

johannes
