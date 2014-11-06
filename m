Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415240111-10596-5-git-send-email-jamuraa@chromium.org>
References: <1415240111-10596-1-git-send-email-jamuraa@chromium.org>
	<1415240111-10596-5-git-send-email-jamuraa@chromium.org>
Date: Thu, 6 Nov 2014 17:07:56 +0200
Message-ID: <CABBYNZLxYBWrjUctYQnt3mVqf4+QgnYe0GttJNjF69phfkcp0g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 4/4] GATT shim to src/shared bt_att
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael

On Thu, Nov 6, 2014 at 4:15 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> This patch implements a version of GAttrib which is backed by
> bt_att, which enables the simultaneous use of GAttrib and bt_att.
>
> This should enable smooth transition of profiles from the GAttrib
> API to the src/shared bt_att API.
> ---
>  attrib/gattrib.c | 1077 ++++++++++++++++--------------------------------------
>  1 file changed, 319 insertions(+), 758 deletions(-)
>  rewrite attrib/gattrib.c (80%)

I tried it and it does not pass the unit tests:

/gattrib/register: **
ERROR:unit/test-gattrib.c:479:test_register: assertion failed:
(current_pdu->received)

Also, we need to make sure it does cause any regressions to android-tester:

>sudo android/android-tester -d -p "Gatt":

Test Summary
------------
Gatt Init                                            Passed       0.012 seconds
Gatt Client - Register                               Passed       0.012 seconds
Gatt Client - Unregister                             Passed       0.013 seconds
Gatt Client - Scan                                   Passed       0.018 seconds
Gatt Client - LE Connect                             Passed       0.037 seconds
Gatt Client - LE Disconnect                          Passed       0.042 seconds
Gatt Client - LE Multiple Client Conn./Disc.         Passed       0.036 seconds
Gatt Client - Listen and Disconnect                  Passed       0.035 seconds
Gatt Client - Double Listen                          Passed       0.065 seconds
Gatt Client - Search Service - Single                Timed out    3.420 seconds
Gatt Client - Search Service - Multiple              Timed out    3.004 seconds
Gatt Client - Search Service - None                  Passed       0.043 seconds
Gatt Client - Get Characteristic - Single            Timed out    2.964 seconds
Gatt Client - Get Characteristic - None              Passed       0.041 seconds
Gatt Client - Get Descriptor - Single                Timed out    2.948 seconds
Gatt Client - Get Descriptor - Multiple              Timed out    3.000 seconds
Gatt Client - Get Descriptor - None                  Timed out    3.002 seconds
Gatt Client - Get Included Service - 16 UUID         Timed out    3.005 seconds
Gatt Client - Get Included Service - 128 UUID        Timed out    2.999 seconds
Gatt Client - Get Included Service - None            Timed out    2.996 seconds
Gatt Client - Read Characteristic - Success          Timed out    2.999 seconds
Gatt Client - Read Characteristic - Insuf. Auth.     Timed out    2.998 seconds
Gatt Client - Read Characteristic - Wrong params     Timed out    3.001 seconds
Gatt Client - Read Descriptor - Success              Timed out    3.009 seconds
Gatt Client - Read Descriptor - Insuf. Auth.         Timed out    2.992 seconds
Gatt Client - Read Descriptor - Wrong params         Timed out    3.006 seconds
Gatt Client - Write Characteristic Cmd - Success     Timed out    3.000 seconds
Gatt Client - Write Characteristic Req - Success     Timed out    3.004 seconds
Gatt Client - Write Characteristic - Insuf. Auth.    Timed out    2.991 seconds
Gatt Client - Write Characteristic - Wrong Params    Passed       0.018 seconds
Gatt Client - Register For Notification - Success    Timed out    2.977 seconds
Gatt Client - Deregister For Notification - Success  Timed out    3.010 seconds
Gatt Client - Register For Notification - Indicate   Timed out    3.001 seconds
Gatt Client - Register For Notification - Notify     Timed out    2.994 seconds
Gatt Client - Write Descriptor - Success             Timed out    3.002 seconds
Gatt Client - Write Descriptor - Insuf. Auth.        Timed out    2.999 seconds
Gatt Client - Write Descriptor - Wrong Param         Timed out    3.001 seconds
Gatt Server - Register                               Passed       0.027 seconds
Gatt Server - Unregister                             Passed       0.021 seconds
Gatt Server - LE Connect                             Passed       0.039 seconds
Gatt Server - LE Disconnect                          Passed       0.036 seconds
Gatt Server - LE Multiple Server Conn./Disc          Passed       0.032 seconds
Gatt Server - Add Single Service Successful          Passed       0.016 seconds
Gatt Server - Add Multiple Services Successful       Passed       0.016 seconds
Gatt Server - Add Service with 0 handles             Passed       0.013 seconds
Gatt Server - Add Secondary Service                  Passed       0.012 seconds
Gatt Server - Add Included Service Successful        Passed       0.015 seconds
Gatt Server - Add Inc. Service with wrong handle     Passed       0.014 seconds
Gatt Server - Add Single Characteristic Successful   Passed       0.018 seconds
Gatt Server - Add Char. wrong service handle         Passed       0.015 seconds
Gatt Server - Add Single Descriptor Successful       Passed       0.017 seconds
Gatt Server - Add Desc. wrong service handle         Passed       0.015 seconds
Gatt Server - Add Desc. wrong app ID                 Passed       0.013 seconds
Gatt Server - Start Service Successful BREDRLE       Passed       0.014 seconds
Gatt Server - Start Service Successful LE            Passed       0.016 seconds
Gatt Server - Start Service wrong service handle     Passed       0.014 seconds
Gatt Server - Start Service wrong server transport   Passed       0.016 seconds
Gatt Server - Stop Service Successful                Passed       0.015 seconds
Gatt Server - Stop Service wrong service handle      Passed       0.017 seconds
Gatt Server - Delete Service Successful              Passed       0.014 seconds
Gatt Server - Delete Service wrong handle            Passed       0.017 seconds
Gatt Server - Send Indication                        Timed out    3.557 seconds
Gatt Server - Send Notification                      Passed       0.033 seconds
Gatt Server - Send Notification, wrong conn id       Passed       0.031 seconds
Gatt Server - Send response to read char request     Timed out    2.943 seconds
Gatt Server - Send response to write char request    Timed out    2.997 seconds

Total: 66, Passed: 38 (57.6%), Failed: 28, Not Run: 0
