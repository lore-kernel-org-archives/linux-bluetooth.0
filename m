Return-Path: <cyrus@holtmann.org>
Date: Sun, 3 Jul 2011 14:38:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix common misspelled words
Message-ID: <20110703113817.GA10186@dell.ger.corp.intel.com>
References: <1309620760-17968-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1309620760-17968-2-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309620760-17968-2-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Sat, Jul 02, 2011, Lucas De Marchi wrote:
> Accounting of misspelled words, as detected by codespell:
> 
> acording      2
> ancilliary    1
> appropiate    1
> atribute      1
> cant          1
> comming       2
> gracefull     1
> lenght        1
> mispelled     1
> occured       1
> occurences    1
> ocurred       3
> prefered      1
> presense      1
> reponse       1
> seperate      1
> succesful     1
> successully   1
> sucessfull    1
> sucessfully   1
> ---
>  attrib/att.c         |    2 +-
>  attrib/gatttool.c    |    2 +-
>  audio/avdtp.c        |    4 ++--
>  audio/gstavdtpsink.c |    6 +++---
>  audio/gstsbcutil.c   |    2 +-
>  audio/ipc.h          |    2 +-
>  doc/adapter-api.txt  |    2 +-
>  doc/audio-api.txt    |    2 +-
>  health/mcap.c        |    2 +-
>  serial/proxy.c       |    2 +-
>  src/sdpd-request.c   |    4 ++--
>  test/apitest         |    2 +-
>  test/bdaddr.c        |    2 +-
>  test/sap-client      |    2 +-
>  test/test-health     |    2 +-
>  tools/hciattach.c    |    4 ++--
>  tools/rfcomm.1       |    2 +-
>  tools/ubcsp.c        |    4 ++--
>  18 files changed, 24 insertions(+), 24 deletions(-)

Applied. Thanks.

Johan
