Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Aug 2011 11:34:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 00/22] Implement AVRCP 1.3 for TG role
Message-ID: <20110812083422.GD19448@dell>
References: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Aug 11, 2011, Lucas De Marchi wrote:
> Change from previous version:
> 
> - MediaPlayer interface is created only if remote device is the controller (and
>   thus we are TG) as suggested by Luiz.
> 
> Lucas De Marchi (22):
>   audio: move interface declarations to their headers
>   avrcp: add skeleton of MediaPlayer interface
>   avrcp: implement SetProperty() method of MediaPlayer
>   avrcp: implement ChangePlayback() method
>   avrcp: implement ChangeTrack() method
>   avrcp: handle query for company ids
>   avrcp: handle ListPlayerApplicationSettingAttributes pdu
>   avrcp: handle ListPlayerApplicationSettingValues pdu
>   avrcp: handle GetCurrentPlayerAplicationSettingValue pdu
>   avrcp: handle SetPlayerApplicationSettingValue pdu
>   avrcp: handle commands for future extension
>   avrcp: handle InformDisplayableCharacterSet pdu
>   avrcp: handle InformBatteryStatusOfCT pdu
>   avrcp: handle GetPlayStatus pdu
>   avrcp: handle RegisterNotification pdu
>   avrcp: handle query for supported events
>   avrcp: handle GetElementAttributes pdu
>   avrcp: send response for registered events
>   avrcp: change TG record to use version 1.3
>   avrcp: update copyright
>   Add script to test MediaPlayer interface
>   Update Control documentation
> 
>  audio/control.c        | 1417 +++++++++++++++++++++++++++++++++++++++++++++++-
>  audio/control.h        |    7 +-
>  audio/device.h         |    4 -
>  audio/manager.c        |   14 +-
>  audio/manager.h        |    1 +
>  audio/unix.c           |    1 +
>  doc/control-api.txt    |   94 ++--
>  test/test-media-player |  108 ++++
>  8 files changed, 1580 insertions(+), 66 deletions(-)
>  create mode 100755 test/test-media-player

All patches have been applied. Thanks.

Additionally applied an extra cleanup patch on top of them for some
coding style issues. Please take a look that e.g. the avctp_send_event
change is correct.

Johan
