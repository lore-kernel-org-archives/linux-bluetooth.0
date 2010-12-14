Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Dec 2010 16:44:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pawel Wieczorkiewicz <pawel.wieczorkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Error should be returned instead of unnecessary
 dict_append_array()
Message-ID: <20101214144448.GA10118@jh-x301>
References: <1292336427-20380-1-git-send-email-pawel.wieczorkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292336427-20380-1-git-send-email-pawel.wieczorkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pawel,

On Tue, Dec 14, 2010, Pawel Wieczorkiewicz wrote:
> If there are no adapter up and running, there would be
> no elements to be added using dict_append_array(). We
> should return DBus error ".DoesNotExist", rather than
> appending NULL pointer and zero elements.
> 
> On behalf of ST-Ericsson SA
> ---
>  src/manager.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

Nack. Manager.GetProperties shouldn't fail if there no adapters. There
will be more properties coming in the future (a "DefaultAdapter"
property for sure) and could either have an empty array for the Adapters
or just leave out that key from the dictionary (i.e. in the worst case
we've got an empty dictionary, but that's fine too imho).

Johan
