Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4721B276.5070101@free.fr>
Date: Fri, 26 Oct 2007 11:25:10 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4720DF23.6040607@silicom.fr> <1193352198.6184.280.camel@violet>
In-Reply-To: <1193352198.6184.280.camel@violet>
Cc: Johan Hedberg <johan.hedberg@nokia.com>,
        Brad Midgley <bmidgley@xmission.com>
Subject: Re: [Bluez-devel] Bluez DBUS API usuability regarding
	end	user	experience
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

Marcel Holtmann wrote:
> Hi Fabien,
> 
>> I have a (kind of) formal request to ask to the Bluez project.
>>
>> I'm basically trying to use the Bluez API to design a user friendly 
>> device that will have bluetooth functionnality.
>> Speeking of a user friendly device, i'm thinking of two things i wanna have:
>>    - the end user bluetooth feature should work most of the time, which
>> means it will have to be robust and not throw errors most of the time.
>>    - When something goes wrong, the end user should only be presented 
>> with error messages he can understand and actually act upon. If the 
>> message is too cryptic, then a generic placeholder would be use instead 
>> of a low level message. One of the first non cryptic messages i think of 
>> would be a "Device unreachable : please check your bluetooth device is 
>> powered on" message :-)
> 
> feel free to improve the error messages. We haven't spend enough time
> with them yet. There were other issues that needed to be addressed
> first. Also the error support should made generic and reside in common/.
> So if you wanna work on it, send patches.

Hi Marcel,

I didn't though error handling was that bad. :-(
And... yes i volunteer to work on this, so i'm gonna start to work on 
generic error support in common/. :-)

Cheers,

Fabien


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
