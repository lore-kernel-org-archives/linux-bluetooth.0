Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Mar 2012 13:51:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	lucas.demarchi@profusion.mobi
Subject: Re: [PATCH v3] avrcp: Add error code for rejected vendor command
Message-ID: <20120313115118.GA30313@x220.ger.corp.intel.com>
References: <CAMOw1v6pNC7eebGEAMLEWKNJ8NaR2aUweigMCEzbG5_0wgkUTA@mail.gmail.com>
 <1331137394-27292-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331137394-27292-1-git-send-email-michal.labedzki@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Wed, Mar 07, 2012, Michal Labedzki wrote:
> Fix response for any vendor commands when there are no players
> registered. According to the specification responses should be
> REJECTED with error code.
> 
> "For error response PDU the response parameter is always the
> error code independent of the response format defined for
> ACCEPTED PDU response for the corresponding PDU command."
> (source: section 4.7.9 of AVRCP 1.3 specification)
> ---
>  audio/avctp.c |    4 +++-
>  audio/avrcp.c |   15 +++++++++++++++
>  audio/avrcp.h |    2 ++
>  3 files changed, 20 insertions(+), 1 deletions(-)

Patch 1/3 as well as this one have been applied. Thanks.

Johan
