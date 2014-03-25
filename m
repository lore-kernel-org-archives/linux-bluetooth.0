Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Mar 2014 17:24:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v0] gatt: Move Characteristic properties to
 attrib/gatt.h
Message-ID: <20140325152457.GA22315@t440s.P-661HNU-F1>
References: <1395758579-28846-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395758579-28846-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Mar 25, 2014, Claudio Takahasi wrote:
> Properties are defined by GATT specification. This patch moves and
> renames the defines related to Characteristic properties bits from
> attrib/att.h to attrib/gatt.h
> ---
>  attrib/att.h                       | 10 ----------
>  attrib/gatt-service.c              | 12 ++++++------
>  attrib/gatt.h                      | 18 ++++++++++++++++++
>  plugins/gatt-example.c             | 20 ++++++++++----------
>  profiles/alert/server.c            | 20 ++++++++++----------
>  profiles/input/hog.c               |  4 ++--
>  profiles/proximity/immalert.c      |  2 +-
>  profiles/proximity/linkloss.c      |  2 +-
>  profiles/proximity/reporter.c      |  2 +-
>  profiles/thermometer/thermometer.c |  4 ++--
>  profiles/time/server.c             | 10 +++++-----
>  src/attrib-server.c                |  4 ++--
>  12 files changed, 58 insertions(+), 50 deletions(-)

Applied. Thanks.

Johan
