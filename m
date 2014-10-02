Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412237461-20373-1-git-send-email-jakub.tyszkowski@tieto.com>
Date: Thu, 2 Oct 2014 14:22:17 +0300
Message-ID: <CABBYNZLciwUPMPd8UyRThAALi2L0Xv1K57QzDWOzF0yNOPM-XA@mail.gmail.com>
Subject: Re: [PATCHv4 00/13] android/tester: Unifying the way PDU is handled
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, Oct 2, 2014 at 11:10 AM, Jakub Tyszkowski
<jakub.tyszkowski@tieto.com> wrote:
> This patchset makes all testers use common struct for using raw data (PDUs).
> Also some helpers were added for pdu matching and sending.
>
> v4 changes:
>   * patches were redone with iovectors from the start,
>   * sdp pdu sending was improved (no need to have non const pdus anymore)
>
> v3 changes:
>   * added one more patch replacing the pdu struct with iovec and making testers
>     use bthost's iovec specific API.
>   * minor include fix
>   * minor commit message correction
>
> v2 changes:
>   * added generic hook and connect callback in tester-main for handling simple
>     cases when only pdu exchange is needed on given channel
>
> Jakub Tyszkowski (13):
>   android/tester: Replace gatt-tester's pdu structs with io vectors
>   android/tester: Expose structs holding request pdu and response pdu
>   android/tester: Make HidHost tests use io vectors for pdu
>   android/tester: Make PAN tests use io vectors for pdu
>   android/tester: Make HDP tests use io vectors for pdu
>   android/tester: Add generic hook to handle pdu exchange
>   android/tester: Make A2DP use generic pdu exchange mechanism
>   android/tester: Make AVRCP tests use generic pdu exchange mechanism
>   android/tester: Make GATT use generic cid_data
>   android/tester: Make HDP tests use generic PDU exchange mechanism
>   android/tester: Make HIDHost tests use generic PDU exchange mechanism
>   android/tester: Make PAN use generic PDU exchange mechanism
>   android/tester: Use generic connect callback for simple cases
>
>  android/tester-a2dp.c    | 108 +++++++--------------
>  android/tester-avrcp.c   | 180 +++++++++++++----------------------
>  android/tester-gatt.c    |  95 +++++++------------
>  android/tester-hdp.c     | 200 ++++++++++++++++-----------------------
>  android/tester-hidhost.c | 241 +++++++++++++++++++++--------------------------
>  android/tester-main.c    |  71 ++++++++++++++
>  android/tester-main.h    |  26 +++++
>  android/tester-pan.c     |  45 +++------
>  8 files changed, 430 insertions(+), 536 deletions(-)
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
