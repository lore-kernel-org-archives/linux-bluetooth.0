Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100710132021o60ae76auf64c6cb5cfe702db@mail.gmail.com>
Date: Sun, 14 Oct 2007 00:21:06 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000401c80ccb$a7cb44b0$c72915ac@NOE.Nokia.com>
MIME-Version: 1.0
References: <000401c80ccb$a7cb44b0$c72915ac@NOE.Nokia.com>
Subject: Re: [Bluez-devel] PATCH2/2: bluez-utils - avoid-unnecessary-polls
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Kai,

On 10/12/07, Kai Vehmanen <kai.vehmanen@nokia.com> wrote:
> Hello again,
>
> here's the second patch to ALSA A2DP plugin in bluez-utils
> (see my previous mail).
>
> This patch changes the worker thread poll timeout to be
> calculated according to application chosen period size.
> This allows to decrease the CPU load significantly for those
> applications that do not require an ultra small period
> size. Without the patch (poll timeout of 1msec), the system
> call load is pretty heavy...

This was done before but I guess for some reason I don't remember
now we remove it in favor of fixed timeout. Thought we should
reconsider it if it has a good impact on CPU load.

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
