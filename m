Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 22:57:12 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Split up object and session in pbap.c
Message-ID: <20101111205712.GB22890@jh-x301>
References: <1289460972-2971-1-git-send-email-dmitriy.paliy@nokia.com>
 <1289490660-14884-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289490660-14884-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Nov 11, 2010, Dmitriy Paliy wrote:
> Object and session data is separated in PBAP plugin. Reason is that
> when OBEX session firstly makes disconnect of service_data, which
> corresponds to session in pbap.c, it than closes object, which also
> corresponds to session in pbap.c.
> 
> Memory is deallocated after PBAP session is disconnected. When OBEX
> driver closes the object, it is trying to dereference the deallocated
> memory in order to free pbap->buffer data.
> 
> Here object and session are separated, while pointers are created to
> make one-to-one mapping. pbap_object is created in vobject_..._open
> functions after query to tracker submitted. Session and object are
> handled separately when freed.
> ---
>  plugins/pbap.c |   94 +++++++++++++++++++++++++++++++++++---------------------
>  1 files changed, 59 insertions(+), 35 deletions(-)

The patch has been pushed upstream. Thanks.

Johan
