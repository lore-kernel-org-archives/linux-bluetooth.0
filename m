Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Apr 2010 20:35:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Francisco Alecrim <francisco.alecrim@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Services through DBus and correct EIR
Message-ID: <20100407173524.GA31884@jh-x301>
References: <1270657550-28767-1-git-send-email-francisco.alecrim@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1270657550-28767-1-git-send-email-francisco.alecrim@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alecrim,

On Wed, Apr 07, 2010, Francisco Alecrim wrote:
> * Third version:
> ** Indent change at adapter_emit_uuids_updated
> ** Use g_strfreev instead of loop to free **uuids.
> 
> Francisco Alecrim (2):
>   Report local services(UUIDs) through DBus
>   Correct UUIDs list to EIR
> 
>  doc/adapter-api.txt |    5 +++
>  src/adapter.c       |   87 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  src/adapter.h       |    2 +
>  src/sdpd-database.c |    4 ++
>  src/sdpd-service.c  |    5 ++-
>  src/sdpd.h          |    3 +-
>  test/list-devices   |    3 ++
>  7 files changed, 104 insertions(+), 5 deletions(-)

Thanks for the updated patches! They are now pushed upstream. It seems
you missed my point about other indentation issues than the one I
explicitly pointed out, but I went ahead and fixed that in a separate
commit to avoid a new feedback round for such a minor issue.

Johan
