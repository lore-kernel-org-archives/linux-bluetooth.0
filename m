Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1385391283-10962-1-git-send-email-luiz.dentz@gmail.com>
References: <1385391283-10962-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 26 Nov 2013 15:46:47 +0200
Message-ID: <CABBYNZL-T4z2A99+dUw=DP5W5G286FSmf3wAewz+jaS2p1Krhg@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] Initial AVDTP for Android
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 25, 2013 at 4:54 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The code is based on the current implementation available in
> profiles/audio/avdtp.{c,h} but it is transport agnostic and does not
> contain any external dependency except glib for IO handling.
>
> Both the signaling and the transport connection has to be handled by
> the upper layer, that is why it is not modified in place to avoid
> breaking current implemention until this work is considered stable.
>
> Two new function are added:
>
>   - avdtp_new: Creates AVDTP session and attach signaling transport
>   - avdtp_stream_set_transport: Set stream transport
>
> Both receives a fd as parameter so in future it should be possible to
> replace the IO handling.
>
> This set also includes a initial test set based on the current AVDTP
> test specification, once merged more tests will be added as well,
> then the intent is to make this used by audio plugin.
>
> Note: It is possible to track back to the original code by doing:
> git log --follow or git blame -C -C.
>
> v2: Add a separate commit to copy existing AVDTP files
>
> Luiz Augusto von Dentz (20):
>   android: Add copy of current AVDTP implemention
>   android/AVDTP: Strip dependencies
>   unit/AVDTP: Add /TP/SIG/SMG/BV-05-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-06-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-07-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-08-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-09-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-10-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-11-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-12-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-15-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-16-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-17-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-18-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-19-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-20-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-21-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-22-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-23-C test
>   unit/AVDTP: Add /TP/SIG/SMG/BV-24-C test
>
>  Makefile.am         |    8 +
>  android/Makefile.am |    1 +
>  android/a2dp.c      |   23 +
>  android/avdtp.c     | 3256 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  android/avdtp.h     |  275 +++++
>  unit/test-avdtp.c   |  612 ++++++++++
>  6 files changed, 4175 insertions(+)
>  create mode 100644 android/avdtp.c
>  create mode 100644 android/avdtp.h
>  create mode 100644 unit/test-avdtp.c
>
> --
> 1.8.3.1

This set is now upstream.


-- 
Luiz Augusto von Dentz
