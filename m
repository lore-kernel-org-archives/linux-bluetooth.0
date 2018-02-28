Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180226155336.25875-1-luiz.dentz@gmail.com>
References: <20180226155336.25875-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Feb 2018 18:09:38 +0200
Message-ID: <CABBYNZKwZKn=x4Ur_CwFjy1C6duAHBem8H1rKo289sOG9mLbng@mail.gmail.com>
Subject: Re: [PATCH BlueZ 00/14] shared/shell: Add proper support for
 non-interactive mode
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 26, 2018 at 5:53 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds functionally to bt_shell to properly handle non-interactive
> mode making all command line tools handle commands given as argument:
>
>>./bluetoothctl power on
> [CHG] Controller B8:8A:60:D8:17:D7 Class: 0x002c010c
> Changing power on succeded
>
> While on non-interactive mode readline will not be used and only the
> command line arguments will be processed, in addition to that there
> is now bt_shell_noninteractive_quit which shall be used by the command
> handler to quit when it is done with the command execution.
>
> Luiz Augusto von Dentz (14):
>   shared/shell: Add bt_shell_{noninteractive_}quit
>   shared/shell: Fix not reseting optind
>   shared/shell: Fix timeout parameter
>   shared/shell: Do not quit immediatelly on noninteractive mode
>   shared/shell: Fix not handling sort options
>   shared/shell: Disable bt_shell_prompt_input in noninteractive mode
>   shared/shell: Disable readline while in noninteractive mode
>   sharead/mainloop-glib: Fix mainloop_exit*
>   shared/mainloop-glib: Fix calling g_main_loop_quit with NULL
>   shared/shell: Allow executing submenu commands
>   client: Call bt_shell_noninteractive_quit when done with command
>   shared/shell: Add bt_shell_usage
>   shared/shell: Fix parsing of mandatory arguments
>   tools/btmgmt: Port to use bt_shell
>
>  client/advertising.c       |   84 ++-
>  client/gatt.c              |  113 ++--
>  client/main.c              |  153 +++--
>  src/shared/mainloop-glib.c |    5 +
>  src/shared/shell.c         |  130 +++-
>  src/shared/shell.h         |    4 +
>  tools/btmgmt.c             | 1560 ++++++++++++++++----------------------------
>  7 files changed, 905 insertions(+), 1144 deletions(-)

Applied.

-- 
Luiz Augusto von Dentz
