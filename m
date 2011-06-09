Return-Path: <cyrus@holtmann.org>
Subject: Re: How to contribute to Bluetooth profiles still not adopted by BT SIG?
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Elvis Pfutzenreuter <epx@signove.com>
In-Reply-To: <BANLkTi=Q2oufRQOgqmn_EqfV4EVCO2B0EA@mail.gmail.com>
Date: Thu, 9 Jun 2011 10:20:34 -0300
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <6E4AFC41-A4B8-44FC-B715-D7BAFEB264FA@signove.com>
References: <BANLkTi=Q2oufRQOgqmn_EqfV4EVCO2B0EA@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Jun 9, 2011, at 8:09 AM, Anderson Lizardo wrote:

> Hi,
> 
> I would like to bring another discussion (hoping that someone cares
> about the same issue as well :).
> 
> Recently, the first GATT based profile was finally adopted by BT SIG:
> http://e2e.ti.com/blogs_/b/bluetooth_low_energy_blog/archive/2011/06/07/first-bluetooth-low-energy-profile-adopted.aspx
> . This means we can now finally work on it without fear of discussing
> things which are confidential.
> 
> But what about all those other draft profiles? For sure some of you
> are already working on some of them (we included), but looks like we
> cannot discuss publicly or share code... or can we?
> 
> What has been the policy on non-GATT profiles? I'm not involved on
> BlueZ development long enough to even have seen how the other non-GATT
> profiles have been implemented.
> 
> If confidentiality is still necessary, could we have an invite-only
> mailing list for discussing and sharing code (at least for as long as
> the profile is not adopted).

At first sight, some list with people having account in SIG would do.

For example, "that" page that is the primary source of most practical
information (UUIDs etc.) you need to implement a GATT profile.
Current policy is allow access only for people with a SIG account.
Once you are logged in, it shows infos for adopted as well as non-adopted
profiles.

The remaining problem is the profiles that didn't even reach the stage of
appearing in the Web page. Information about that ones is
"trapped" inside each working group. As far as I understand, it can't
be shared even with SIG members that are not part of the same WG.