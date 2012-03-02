Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Mar 2012 10:39:17 +0100
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 2/3] avrcp: Add error code for rejected vendor command
Message-ID: <20120302093917.GB27242@uw000554.eu.tieto.com>
References: <1330613135-16552-1-git-send-email-michal.labedzki@tieto.com>
 <1330613135-16552-2-git-send-email-michal.labedzki@tieto.com>
 <CABBYNZL5go4LSXbzx5qyEDg2quMqNJ+n+A+qsL+ybSv99FzPyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CABBYNZL5go4LSXbzx5qyEDg2quMqNJ+n+A+qsL+ybSv99FzPyg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 01, 2012 at 05:34:19PM +0200, Luiz Augusto von Dentz wrote:
> Hi Michal,
> 
> On Thu, Mar 1, 2012 at 4:45 PM, Michal Labedzki
> <michal.labedzki@tieto.com> wrote:
> > Make correct response for any vendor commands when there are not any
> > registered player. According to the specification responses should be
> > REJECTED with error code.
> 
> Please quote the spec whenever possible, actually what spec does this come from?
> 
> 
> -- 
> Luiz Augusto von Dentz

Hi Luiz,                                                                                                                                             
                                                                                                                                                     
Here you are:                                                                                                                                        
"For error response PDU the response parameter is always the error code independent                                                                  
of the response format defined for ACCEPTED PDU response for the corresponding                                                                       
PDU command."                                                                                                                                        
(source: AVRCP 1.3 specification, pages 34,56 or AVRCP 1.4 specification, pages 33,93)                                                               
                                                                                                                                                     
All other error responses already have error code in parameter list.


