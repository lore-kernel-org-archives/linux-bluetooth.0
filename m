Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Adding services in the Service Class ID list
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050427015939.86545.qmail@web20921.mail.yahoo.com>
References: <20050427015939.86545.qmail@web20921.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1114598097.10706.390.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 27 Apr 2005 12:34:57 +0200

Hi Arch,

> Thanks for the immediate response.
> I appreciate your looking into the concern/issue
> that I have.
> 
> Here is the part of code where I add the services
> in the Service Class ID list.
> 
> 
> ==========================================
> sdp_uuid16_create(&headsetaudiogateway_uuid,
> HEADSET_AGW_SVCLASS_ID);
> svclass_id[0] = sdp_list_append(0,
> &headsetaudiogateway_uuid);
> scseq = sdp_list_append(0, svclass_id[0]);
>    
> sdp_uuid16_create(&genericaudio_uuid,
> GENERIC_AUDIO_SVCLASS_ID);
> svclass_id[1] = sdp_list_append(0,
> &genericaudio_uuid);
> scseq = sdp_list_append(scseq, svclass_id[1]);
>    
> servclasses = sdp_list_append(0, scseq);
> sdp_set_service_classes(&record, servclasses);
> ===========================================
> 
> is this the right way of adding the services in
> the service class id list?

looks good so far. Send the whole code so that I can test it on my
systems. Do you use the latest library and utils?

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
