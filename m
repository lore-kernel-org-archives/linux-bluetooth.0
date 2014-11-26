Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Nov 2014 10:04:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/4] Add GET/SET_REPORT support to HoG
Message-ID: <20141126080427.GA16861@t440s>
References: <1416580906-22134-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416580906-22134-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Fri, Nov 21, 2014, David Herrmann wrote:
> Benjamin Tissoires (4):
>   hog: import latest uhid.h definition
>   hog: break out the report retrieval in its own function
>   hog: implement get_report functionality
>   hog: implement set_report functionality
> 
>  profiles/input/hog.c       | 204 +++++++++++++++++++++++++++++++++++++++++----
>  profiles/input/uhid_copy.h | 117 +++++++++++++++++++++++---
>  2 files changed, 292 insertions(+), 29 deletions(-)

All these patches have been applied upstream. There was just a minor
thing I fixed myself with a follow-up patch where the code was doing an
unnecessary < 0 comparison of an unsigned value.

Johan
