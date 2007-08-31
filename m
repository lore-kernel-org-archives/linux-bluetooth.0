Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0708310602m642c03dche943524ae40aae7c@mail.gmail.com>
Date: Fri, 31 Aug 2007 10:02:06 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <b150d3010708302129i6fd6c829tc618ecf66f97c07@mail.gmail.com>
MIME-Version: 1.0
References: <b150d3010708302129i6fd6c829tc618ecf66f97c07@mail.gmail.com>
Subject: Re: [Bluez-devel] activating bluez service
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On 8/31/07, Shankar Ramesh <hrshankar@gmail.com> wrote:
> Hi,
>
> I am trying to activate serial service using bluez dbus api  (C program)
> (dbus-glib bindings to call remote methods)  ((activateservice(pattern)).  i
> get the following error
>
> Remote method:  ActivateService (pattern)
>
> Error message: Method "ActivateService" with signature "s" on interface
> "org.bluez.Manager" doesn't exist
>
>
> Can anyone tell me how to use these services..

Hi Ramesh,

maybe your path is wrong. Check if it is: "/org/bluez"

BR,
Claudio
-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
