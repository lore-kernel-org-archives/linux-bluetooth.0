Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426097463-5288-1-git-send-email-marcin.kraglak@tieto.com>
References: <1426097463-5288-1-git-send-email-marcin.kraglak@tieto.com>
Date: Fri, 13 Mar 2015 14:09:38 +0200
Message-ID: <CABBYNZK+1x5GU87mm4uGocNK4=meq+Hccsa+ejxubTNUYOAUJw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix collision in AVCTP connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Mar 11, 2015 at 8:10 PM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> This patch set corresponds to previous RFC with the same subject.
> Now reconnection logic is moved to policy. Avrcp and avctp
> modules are responsible for passing correct error to higher
> layer, policy detects collision and set random timer for reconnection.
> Comments are welcome
>
> Marcin Kraglak (4):
>   audio/avctp: Pass error argument to avctp_state_changed callback
>   audio/avrcp: Pass error to session_destroy()
>   audio/avctp: Cancel outgoing connection in case of conflict
>   plugins/policy: Try reconnect Control/Target services
>
>  plugins/policy.c         | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
>  profiles/audio/avctp.c   | 45 ++++++++++++++++-----------
>  profiles/audio/avctp.h   |  2 +-
>  profiles/audio/avrcp.c   | 11 ++++---
>  profiles/audio/control.c |  3 +-
>  5 files changed, 116 insertions(+), 25 deletions(-)
>
> --
> 2.1.0

Applied, thanks.


-- 
Luiz Augusto von Dentz
