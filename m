Return-Path: <brian.gix@intel.com>
From: Brian Gix <brian.gix@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v2 0/1] Allow Non-Ephemeral ECC Key Sets
Date: Fri, 27 Apr 2018 10:10:48 -0700
Message-Id: <20180427171049.2250-1-brian.gix@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Version 2, to address uninitialized private_key issue, by adding a new
API. This is separates the two major tasks of generating ECC key sets,
which are:

a) Create a Private Key (Only used here when creating Ephemeral set)
b) Create the matching Public Key from the Private Key.

In hindsight, we may have wanted to call the original API something like
ecc_make_keys() or ecc_make_key_set() instead of the singlular ecc_make_key.
Making that change now will require more wide-reaching changes, however. But
I am willing to do it in a v3 if people think it better.

Some minor spelling/capitalization issues were also addressed

Mesh will be the first to use non-Ephemeral keys

Brian Gix (1):
  shared/ecc: Allow pre-composed Private Keys

 src/shared/ecc.c | 42 +++++++++++++++++++++++++++++-------------
 src/shared/ecc.h | 17 ++++++++++++++---
 2 files changed, 43 insertions(+), 16 deletions(-)

-- 
2.14.3
