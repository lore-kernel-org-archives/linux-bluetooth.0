Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C7D992.7040401@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco.41 not compiling
References: <43C69F77.8050701@pagestation.com> <43C7D767.8080501@xmission.com> <43C7D8B8.1060701@messagenetsystems.com>
In-Reply-To: <43C7D8B8.1060701@messagenetsystems.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 13 Jan 2006 09:47:14 -0700

Jerry Geis wrote:
> gcc -version reports 3.4.4
> 
> I am running a redhat kernel uname -r gives 2.6.9.-22.0.1-EL
> 
> My machine compiles alsa-drivers just fine. It has all kinds of
> module_param_array statesments also....
> Why would this be failing?

so it uses module_params_array similarly? is index declared in the same way?

this stuff was part of a submission i accepted a few months ago to
prevent the btsco adapter from making itself the first adapter. you
could look in cvs for the version before the change.

brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
