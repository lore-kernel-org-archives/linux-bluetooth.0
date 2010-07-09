Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Jul 2010 14:36:18 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: =?iso-8859-1?Q?Jos=E9?= Antonio Santos Cadenas
	<santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Proposed API for HDP
Message-ID: <20100709173618.GA21080@vigoh>
References: <201007081912.31407.santoscadenas@gmail.com>
 <201007091549.42621.santoscadenas@gmail.com>
 <20100709165508.GC22985@vigoh>
 <201007091912.44559.santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201007091912.44559.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* José Antonio Santos Cadenas <santoscadenas@gmail.com> [2010-07-09 19:12:44 +0200]:

> El Friday 09 July 2010 18:55:08 Gustavo F. Padovan escribió:
> > Hi José,
> > 
> > * José Antonio Santos Cadenas <santoscadenas@gmail.com> [2010-07-09 15:49:42 
> +0200]:
> > > I wrote a new API based on the changes suggested in this thread.
> > > 
> > > Regards.
> > > 
> > > Jose.
> > > 
> > > 
> > > BlueZ D-Bus Health API description
> > > **********************************
> > > 
> > > 	Santiago Carot-Nemesio <sancane@gmail.com>
> > > 	José Antonio Santos-Cadenas <santoscadenas@gmail.com>
> > > 	Elvis Pfützenreuter <epx@signove.com>
> > > 
> > > Health Device Profile hierarchy
> > > ===============================
> > > 
> > > Service		org.bluez
> > > Interface	org.bluez.HealthManager
> > > Object path	[variable prefix]/{hci0,hci1,...}
> > > 
> > > Methods:
> > > 	path	RegisterApplication(object path, dict config)
> > > 	
> > > 		Returns the path of the new registered application. The path
> > > 		parameter is the path of the object with the callbacks to
> > > 		notify events (see org.bluez.HealthAgent at the end of this
> > > 		document)
> > > 		This petition starts an mcap instance on every adapter and also
> > > 		register a proper record in the SDP if is needed.
> > > 		
> > > 		Dict is defined as bellow:
> > > 		{
> > > 		
> > > 		  "end_points" : [{ (optional)
> > > 			
> > > 			"role" : ("source" or "sink"), (mandatory)
> > > 			"specs" :[{ (mandatory)
> > > 			
> > > 				"data_type" : uint16, (mandatory)
> > > 				"description" : string, (optional)
> > > 			
> > > 			}]
> > > 			
> > > 		  }]
> > > 		
> > > 		}
> > > 		
> > > 		Application will be closed by the call or implicitly when the
> > > 		programs leaves the bus.
> > > 		
> > > 		Possible errors: org.bluez.Error.InvalidArguments
> > > 	
> > > 	void	UnregisterApplication(path application)
> > > 	
> > > 		Closes the HDP application identified by the object path. Also
> > > 		application will be closed if the process that started it leaves
> > > 		the bus. If there is a SDP record associated to this application
> > > 		it will also be removed.
> > > 		
> > > 		Possible errors: org.bluez.Error.InvalidArguments
> > > 		
> > > 				org.bluez.Error.NotFound
> > > 	
> > > 	void UpdateServices()
> > > 	
> > > 		This method searches for HDP applications on the all remote
> > > 		devices and notifies them to the appropriate agents.
> > > 
> > > -------------------------------------------------------------------------
> > > -------
> > > 
> > > Service		org.bluez
> > > Interface	org.bluez.HealthService
> > > Object path	[variable
> > > prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/hdp_YYYY
> > > 
> > > Methods:
> > > 	array GetProperties()
> > > 	
> > > 		Gets the information of the remote application published on its
> > > 		SDP record. The returned data format is as follows:
> > > 		
> > > 		{
> > > 		
> > > 			"end_points": [
> > > 			
> > > 				"mdepid": uint8,
> > > 				"role"  : "source" or "sink" ,
> > > 				"specs" : [{
> > > 				
> > > 					"dtype"       : uint16,
> > > 					"description" : string, (optional)
> > > 					}]
> > > 				
> > > 				]
> > > 		
> > > 		}
> > 
> > What's the name of this property? See the others APIs, properties need a
> > name.
> 
> I didn't think about properties here (I'm not used to them) But here yes, a 
> property fixes better than a method call.


The method should remain, look the the others APIs. They a have a
Properties section and GetProperties() show all of them.


-- 
Gustavo F. Padovan
http://padovan.org
