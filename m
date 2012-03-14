Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120313142024.GA3157@x220.P-661HNU-F1>
References: <1329771478-3935-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1329771478-3935-3-git-send-email-frederic.dalleau@linux.intel.com>
	<20120313142024.GA3157@x220.P-661HNU-F1>
Date: Wed, 14 Mar 2012 16:11:55 +0100
Message-ID: <CA+QXtDvfVDKQRXMKx73+_S4LN3YE1GoKKEbFxE8VJP4Z5FeRFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sdp: Fix sdp_get_profile_descs for Mac Os X Lion
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> I've applied the first patch since that's quite straight forward but I'm
> struggling a bit with this second one. Firstly you should include the
> hcidump into the commit message as well as a proper explanation. An
> empty commit message (just summary line) is only acceptable for extremely
> trivial patches (and this is far from it).
>
> I *think* I get the main part of the patch, but one thing that's unclear
> is why do you assign next to seq instead of letting the for-loop do it.
> The second branch of the if-statement doesn't do it either so why does
> the first need it? Again, you could have avoided these questions from me
> if you had included an appropriate code comment. Whenever there's
> something counterintuitive in the code it's a good idea to have such a
> comment.
>

This patch just makes sure the correct profile version number is retrieved and
is specific to Mac Os X Lion HFP AG record. SDP is a very sensible piece of
code, and this needs double checking. I'm not even sure that the record itself
is valid so I would surely understand that in order to enforce the standard this
one is not applied.

>From my understanding, the SDP profile descriptor is a list. The for loop
iterates that list. It is unclear in the HFP specification what is contained.
Until now, bluez expected a collection of either uuid or lists with a uuid and a
version number. For example list=(uuid, uuid, (uuid, version), (uuid, version))

The patch fixes the situation where the profile descriptor list contains a uuid
AND a version number both on the root level and not enclosed in a sublist. If
the next item after uuid is uint16, then this is likely to be the
version number of the profile which uuid is given.
list=(uuid, uuid, version, uuid, (uuid, version))

Very easy to reproduce : just run sdptool browse and check the version number of
HFP AG is not 0x105.

However, I'll provide you an updated version with hcidump and a more intuitive
 commit message as soon as I can put my hands on one of these machines again.

Regards,
Frédéric
