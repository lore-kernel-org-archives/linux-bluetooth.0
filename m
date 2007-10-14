Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100710132036l86d5162gda0aa40a9a8a9d4b@mail.gmail.com>
Date: Sun, 14 Oct 2007 00:36:19 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000001c80cca$eff9ed00$c72915ac@NOE.Nokia.com>
MIME-Version: 1.0
References: <000001c80cca$eff9ed00$c72915ac@NOE.Nokia.com>
Subject: Re: [Bluez-devel] PATCH1/2: bluez-utils -
	fix-a2dp-buffer-constraints
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
> This first modifies the buffering constraints as exposed by
> the A2DP ALSA plugin:
>   - increased max overall buffer size to 16384 bytes (~93msecs
>     of CD quality audio, so a reasonable max size)
>   - allow applications to specify buffer size
>   - allow applications to use bigger periods (less wakeup
>     load -> the previous limit of 128 is heavy for apps)

All seems to be good improvements, perhaps brad can comment
about it because he was working with pulse before.

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
