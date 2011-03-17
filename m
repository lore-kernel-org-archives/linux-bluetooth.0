Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Mar 2011 14:52:14 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Add discover characteristics by uuid to gatttool
Message-ID: <20110317125214.GD12238@jh-x301>
References: <1300297246-11056-1-git-send-email-sheldon.demario@openbossa.org>
 <1300312856-14034-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300312856-14034-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Wed, Mar 16, 2011, Sheldon Demario wrote:
> According to the spec the characteristics discover and characteristics discover
> by uuid use the same opcode and the result should be filtered by callback.
> ---
>  attrib/client.c      |    2 +-
>  attrib/gatt.c        |   16 +++++++++++-----
>  attrib/gatt.h        |    3 ++-
>  attrib/gatttool.c    |    3 ++-
>  attrib/interactive.c |   16 ++++++++++++++--
>  5 files changed, 30 insertions(+), 10 deletions(-)

Pushed upstream after manually fixing your commit message: please limit
line lengths to 74 characters.

Johan
