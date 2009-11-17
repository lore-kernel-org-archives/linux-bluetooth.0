Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH] SDP patch to add support for HDP
Date: Tue, 17 Nov 2009 12:08:13 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <200911131343.21326.jcaden@libresoft.es> <f9d4bd30911160952k2041ccc6t2abb4ac280080124@mail.gmail.com>
In-Reply-To: <f9d4bd30911160952k2041ccc6t2abb4ac280080124@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911171208.13972.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

El Monday 16 November 2009 18:52:46 Claudio Takahasi escribió:
> Hi Jose',
>
> gpg disabled :-)
>
> On Fri, Nov 13, 2009 at 10:43 AM, José Antonio Santos Cadenas
>
> <jcaden@libresoft.es> wrote:
> > This patch tries to simplify the way the SDP records for HDP are created.
> > The created functions allow adding supported features easily to an sdp
> > record. The are similar to sdp_set_profile_descs and
> > sdp_get_profile_descs.  I've also added some macros to define new UUID's
> > for HDP.
> Do you have an application or sdptool's patch to test these functions?

We have an HDP/MCAP implementation that uses this functions. We are going to 
release it this week.  Sancane and I are solving some problems with this code. 
We will announce here when this code is available.

About the patch to  sdptool: I didn't do anything but I can do it if you think 
that is a good task.

>
> Br,
> Claudio.
>


I made some changes correcting all the problems that you suggested an other 
that I found. 

Regards,

Jose.

Here's the new pach:

diff --git a/lib/sdp.c b/lib/sdp.c                                        
index 822ec1a..79f1261 100644                                             
--- a/lib/sdp.c                                                           
+++ b/lib/sdp.c                                                           
@@ -4621,3 +4621,87 @@ uint16_t sdp_gen_tid(sdp_session_t *session)       
 {                                                                        
        return session->tid++;                                            
 }                                                                        
+                                                                         
+/*                                                                       
+ * Set the supported features                                            
+ */                                                                      
+void sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf)          
+{                                                                        
+       const sdp_list_t *p, *r;                                          
+       sdp_data_t *feat, *seq_feat;                                      
+                                                                         
+       int seqlen = sdp_list_len(sf);                                    
+       void **seqDTDs = (void **)malloc (seqlen *  sizeof(void *));      
+       void **seqVals = (void **)malloc (seqlen *  sizeof(void *));      
+       int i = 0;                                                        
+                                                                         
+       for (p = sf; p; p = p->next) {                                    
+               int plen = sdp_list_len(p->data);                         
+               void **dtds = (void **)malloc (plen *  sizeof(void *));   
+               void **vals = (void **)malloc (plen *  sizeof(void *));   
+               int j = 0;                                                
+               for (r = p->data; r; r = r->next) {                       
+                       sdp_data_t *data = (sdp_data_t*)r->data;          
+                       dtds[j] = &data->dtd;                             
+                       vals[j] = &data->val;                             
+                       j++;                                              
+               }                                                         
+               feat = sdp_seq_alloc(dtds, vals, plen);                   
+               free(dtds);                                               
+               free(vals);                                               
+                                                                         
+               seqDTDs[i] = &feat->dtd;                                  
+               seqVals[i] = feat;                                        
+               i++;                                                      
+       }                                                                 
+       seq_feat = sdp_seq_alloc(seqDTDs, seqVals, seqlen);               
+                                                                         
+       sdp_attr_replace(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST, seq_feat);
+                                                                         
+       free(seqDTDs);                                                    
+       free(seqVals);                                                    
+}                                                                        
+                                                                         
+/*                                                                       
+ * Get the supported features                                            
+ * If an error occurred -1 is returned and errno is set                  
+ */                                                                      
+int sdp_get_supp_feat (const sdp_record_t *rec, sdp_list_t **seqp)       
+{                                                                        
+       sdp_data_t * sdpdata, *d;                                         
+       sdp_list_t * next;                                                
+       *seqp = NULL;                                                     
+                                                                         
+       sdpdata = sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST);    
+                                                                         
+       if (!sdpdata || sdpdata->dtd < SDP_SEQ8 || sdpdata->dtd > SDP_SEQ32)
+               return sdp_get_uuidseq_attr(rec, 
SDP_ATTR_SUPPORTED_FEATURES_LIST, seqp);
+                                                                                        
+       for (d = sdpdata->val.dataseq; d; d = d->next) {                                 
+               sdp_data_t *dd;                                                          
+               sdp_list_t *subseq;                                                      
+               subseq = NULL;                                                           
+               if ( d->dtd < SDP_SEQ8 || d->dtd > SDP_SEQ32 )                           
+                       goto fail;                                                       
+               for (dd = d->val.dataseq; dd; dd = dd->next) {                           
+                       sdp_data_t *data;                                                
+                       if ( dd->dtd != SDP_UINT8 && dd->dtd != SDP_UINT16 &&            
+                                               dd->dtd != SDP_TEXT_STR8)                
+                               goto fail;                                               
+                       data = sdp_data_alloc(dd->dtd, &dd->val);                        
+                       subseq = sdp_list_append(subseq, data);                          
+               }                                                                        
+               *seqp = sdp_list_append (*seqp, subseq);                                 
+       }                                                                                
+       return 0;                                                                        
+                                                                                        
+fail:                                                                                   
+       while (*seqp) {                                                                  
+               next = (*seqp)->next;                                                    
+               sdp_list_free(*seqp, free);                                              
+               *seqp = next;                                                            
+       }                                                                                
+       errno = EINVAL;                                                                  
+       return -1;                                                                       
+}                                                                                       
+                                                                                        
diff --git a/lib/sdp.h b/lib/sdp.h                                                       
index 375261e..1bb351a 100644                                                            
--- a/lib/sdp.h                                                                          
+++ b/lib/sdp.h                                                                          
@@ -244,13 +244,16 @@ extern "C" {                                                       
 #define SDP_ATTR_GROUP_ID                      0x0200                                   
 #define SDP_ATTR_IP_SUBNET                     0x0200
 #define SDP_ATTR_VERSION_NUM_LIST              0x0200
+#define SDP_ATTR_SUPPORTED_FEATURES_LIST 0x0200
 #define SDP_ATTR_SVCDB_STATE                   0x0201

 #define SDP_ATTR_SERVICE_VERSION               0x0300
 #define SDP_ATTR_EXTERNAL_NETWORK              0x0301
 #define SDP_ATTR_SUPPORTED_DATA_STORES_LIST    0x0301
+#define SDP_ATTR_DATA_EXCHANGE_SPEC            0x0301
 #define SDP_ATTR_FAX_CLASS1_SUPPORT            0x0302
 #define SDP_ATTR_REMOTE_AUDIO_VOLUME_CONTROL   0x0302
+#define SDP_ATTR_MCAP_SUPPORTED_PROCEDURES     0x0302
 #define SDP_ATTR_FAX_CLASS20_SUPPORT           0x0303
 #define SDP_ATTR_SUPPORTED_FORMATS_LIST                0x0303
 #define SDP_ATTR_FAX_CLASS2_SUPPORT            0x0304
diff --git a/lib/sdp_lib.h b/lib/sdp_lib.h
index ee39df8..41d5786 100644
--- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -585,6 +585,19 @@ static inline int sdp_get_icon_url(const sdp_record_t 
*rec, char *str, int len)
        return sdp_get_string_attr(rec, SDP_ATTR_ICON_URL, str, len);
 }

+/*
+ * Set the supported features
+ * sf should be a list of list with each feature data
+ */
+void sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf);
+
+/*
+ * Get the supported features
+ * seqp is set to a list of list with each feature data
+ * If an error occurred -1 is returned and errno is set
+ */
+int sdp_get_supp_feat (const sdp_record_t *rec, sdp_list_t **seqp);
+
 sdp_record_t *sdp_extract_pdu(const uint8_t *pdata, int bufsize, int 
*scanned);
 sdp_record_t *sdp_copy_record(sdp_record_t *rec);




