Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
References: <20180427171049.2250-1-brian.gix@intel.com>
In-Reply-To: <20180427171049.2250-1-brian.gix@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Apr 2018 07:19:38 +0000
Message-ID: <CABBYNZLcUWJ46NdqDciuxwZt=nWmoiAjL6pNM3MiLHc_LMK4ow@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/1] Allow Non-Ephemeral ECC Key Sets
To: "Gix, Brian" <brian.gix@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Fri, Apr 27, 2018 at 8:11 PM Brian Gix <brian.gix@intel.com> wrote:

> Version 2, to address uninitialized private_key issue, by adding a new
> API. This is separates the two major tasks of generating ECC key sets,
> which are:

> a) Create a Private Key (Only used here when creating Ephemeral set)
> b) Create the matching Public Key from the Private Key.

> In hindsight, we may have wanted to call the original API something like
> ecc_make_keys() or ecc_make_key_set() instead of the singlular
ecc_make_key.
> Making that change now will require more wide-reaching changes, however.
But
> I am willing to do it in a v3 if people think it better.

> Some minor spelling/capitalization issues were also addressed

> Mesh will be the first to use non-Ephemeral keys

> Brian Gix (1):
>    shared/ecc: Allow pre-composed Private Keys

>   src/shared/ecc.c | 42 +++++++++++++++++++++++++++++-------------
>   src/shared/ecc.h | 17 ++++++++++++++---
>   2 files changed, 43 insertions(+), 16 deletions(-)


I went ahead and applied this one since the bigger set depending on it,
note that I did have to fix the following warning by checkpatch:

  Applying: shared/ecc: Allow pre-composed Private Keys
WARNING:UNSPECIFIED_INT: Prefer 'unsigned int' to bare use of 'unsigned'
#50: FILE: src/shared/ecc.c:887:
+    unsigned tries = 0;

> --
> 2.14.3



-- 
Luiz Augusto von Dentz
