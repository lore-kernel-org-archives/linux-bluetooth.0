Return-Path: <cyrus@holtmann.org>
Date: Mon, 31 Mar 2014 16:15:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v1 0/3] Add basic GATT descriptors
Message-ID: <20140331131520.GA19896@t440s.lan>
References: <1396267995-17271-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396267995-17271-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Mar 31, 2014, Claudio Takahasi wrote:
> Remaining patches of "[PATCH BlueZ v0 0/5] Add basic GATT descriptors"
> 
> This patchset adds the basic support for GATT descriptors (local GATT
> services) implemented according to doc/gatt-api.txt
> 
> "UUID", and "Value" properties are implemented by this patchset.
> "Characteristic" (parent) is still pending. "Permissions" support is
> not defined yet.
> 
> Changes v0-v1:
>   * Fixed memory leak of descriptor's object path
> 
> Claudio Takahasi (3):
>   tools: Add testing descriptor for IAS Alert Level
>   tools: Add Get/Set descriptor
>   tools: Add emitting descriptor PropertiesChanged
> 
>  tools/gatt-service.c | 128 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 114 insertions(+), 14 deletions(-)

All three patches have been applied. Thanks.

Johan
