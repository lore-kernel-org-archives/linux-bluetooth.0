Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100710141848s5cc34c5bn71c077673114e924@mail.gmail.com>
Date: Sun, 14 Oct 2007 22:48:25 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Fabien Chevalier" <fabchevalier@free.fr>
In-Reply-To: <4712383C.9030200@free.fr>
MIME-Version: 1.0
References: <4712383C.9030200@free.fr>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        Johan Hedberg <johan.hedberg@nokia.com>,
        Brad Midgley <bmidgley@xmission.com>
Subject: Re: [Bluez-devel] [PATCH] Small headset.c fixes
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

Hi Fabien,

On 10/14/07, Fabien Chevalier <fabchevalier@free.fr> wrote:
> Hi All,
>
> Please find attached a rather small patch, that fixes some small issues
> i found while reading headset.c code:
>   * make String representation of state consistent with the state name
>   * send Stop() signal only if we transition from playing state, not
> playin_in_progress
>   * remove unused io_id field.

Thought we should not emit Stopped signal please maintain the code
for sco cleanup (close_sco), sco connection may fail or disconnected
before we got a chance to change the state to playing.

Besides that it seems good to me.

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
