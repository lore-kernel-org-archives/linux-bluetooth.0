Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <462E398D.1010909@vasmac.com>
Date: Tue, 24 Apr 2007 11:08:29 -0600
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <fc27e74b0704240413v5b6e2e80h7b2feb40d27de686@mail.gmail.com>	<462E02FB.8000600@vasmac.com>	<fc27e74b0704240808j3ca3df0cr5c415d39acf29ac4@mail.gmail.com>	<462E21F0.4080204@vasmac.com>
	<1177431197.18086.18.camel@localhost>
In-Reply-To: <1177431197.18086.18.camel@localhost>
Subject: Re: [Bluez-devel] [PATCH]Dynamic Alternate Setting patch	(hci_usb.c)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

alok wrote:
> Jose,
>
> On Tue, 2007-04-24 at 09:27 -0600, Jose Vasconcellos wrote:
>   
>> list subscribe wrote:
>>     
>>> Jose,
>>>
>>>     Hi Alok,
>>>
>>>     This is a good start. There are a few other things to consider:
>>>
>>>     * Are there error conditions in hci_usb_tx_complete that need to
>>>     be handled?
>>>
>>>
>>> I am not sure what you mean.  Since we don't flush submitted  URBs, 
>>> these URBs are handled like normal ones. If their status indicates 
>>> error the error_tx count will be incremented. What error conditions 
>>> are u pointing at?
>>>       
>> The outstanding urbs are dequeued and put on a temporary list and 
>> resubmitted
>> after changing the configuration. But there may be an active URB that is 
>> being
>> transmitted that will be reported with an error status. 
>> hci_usb_tx_complete will
>> release this urb so it can't be resubmitted. This may also result in a 
>> small glitch
>> when switching to an alternate.
>>     
>
> The submitted URBs are dequeued and put into a temporary list but are
> not resubmitted later . Rather after flushing the pending queue , the
> temporary list is appended to pending_queue. 
> So after the setting is changed, we have some previous submitted URBs
> which are in the process of transmission followed by URBs which use the
> changed settings in the pending queue. 
>
> If any urb reports an error, only the tx error count is incremented
> (hdev->stat.err_tx++). 
> And all _urbs are unlinked (whether their urbs return error or not) and
> queued to the complete_q queue.  
>
> I hope this answers your question.
>   
My point is that it's possible that the active URBs that was cancelled
will end up in hci_usb_tx_complete with an error status. You must not
add this URB to the pending queue since the complete routine will
have released it.

>>>     * How do you make sure data for different channels is interleaved?
>>>
>>>
>>> Well , since we know that there can be max 3 SCO channels , we can 
>>> have 3 separate queues, and use a round robin method to send out the 
>>> packets from the queues. i am not sure about this idea though.  What
>>> do u think?
>>>       
>> I think this is the right approach; I found that it's very important to 
>> do the
>> interleaving properly. There is an issue if one of the queues is empty
>> (i.e. buffer underrun). What to do in that case? Send silence?
>>     
> If u hit a underrun on one queue, u ignore that sco channel.What
> difference is it going to make if we sent silence packets on that
> channel?
> I am not sure about this. I have no expertise in audio. if someone can
> justify this solution i can implement it. 
>   
Since we're dealing with voice samples you may get some glitches.
Maybe this is not a big deal.


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
