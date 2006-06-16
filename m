Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v750)
Message-Id: <435B3A56-B448-4E26-8BEB-E0879356ACBB@wideray.com>
To: BlueZ <bluez-devel@lists.sourceforge.net>
From: Jason Watts <jason.watts@wideray.com>
Date: Fri, 16 Jun 2006 16:01:08 -0700
Subject: [Bluez-devel] Bug: infinite loop in extract_seq() when
	sdp_extract_seqtype() fails
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

Hi,

I'm new to this list.  Please let me know if there is a more  
appropriate place to report this.

It appears that extract_seq() in sdp.c (bluez-libs) can enter an  
infinite loop if sdp_extract_seqtype() fails when extract_seq() has  
called itself recursively.  Here's how:

  1  static sdp_data_t *extract_seq(const void *p, int *len,  
sdp_record_t *rec)
  2  {
  3    int seqlen, n = 0;
  4    sdp_data_t *curr, *prev;
  5    sdp_data_t *d = (sdp_data_t *)malloc(sizeof(sdp_data_t));
  6
  7    SDPDBG("Extracting SEQ");
  8    memset(d, 0, sizeof(sdp_data_t));
  9    *len = sdp_extract_seqtype(p, &d->dtd, &seqlen);
10    SDPDBG("Sequence Type : 0x%x length : 0x%x\n", d->dtd, seqlen);
11
12    if (*len == 0)
13      return d;
14
15    p += *len;
16    curr = prev = NULL;
17    while (n < seqlen) {
18      int attrlen = 0;
19      curr = sdp_extract_attr(p, &attrlen, rec);
20      if (curr == NULL)
21        break;
22
23      if (prev)
24        prev->next = curr;
25      else
26        d->val.dataseq = curr;
27      prev = curr;
28      p += attrlen;
29      n += attrlen;
30
31      SDPDBG("Extracted: %d SequenceLength: %d", n, seqlen);
32    }
33
34    *len += n;
35    return d;
36  }


On line 9, sdp_extract_seqtype() will return zero if it does not  
recognize the sequence type.  When this happens, extract_seq() will  
set the output argument len to zero and return a pointer on line 13.   
Note that it will NOT return NULL.  It returns the chunk allocated on  
line 5.

Now, the while loop calls sdp_extract_attr() on line 19.  This call  
sets attrlen.  The loop will not advance if attrlen remains zero.   
sdp_extract_attr() function can in turn call extract_seq() again  
recursively.  When that happens here, the call to sdp_extract_attr()  
is equivalent to calling extract_seq() directly.

The loop would break on line 21 if sdp_extract_attr() returned NULL.   
But sdp_extract_attr() never returns NULL if it calls extract_seq(),  
because extract_seq() never returns NULL.

Thus, if sdp_extract_attr() calls extract_seq(), and then the  
sdp_extract_seqtype() call fails, then the loop will not break,  
because sdp_extract_attr() will return non-NULL, and the loop will  
not advance because attrlen will be zero.


Jason Watts
Embedded Software Engineer
Qwikker, Inc.



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
